Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E6E30ED5C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 08:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbhBDH3t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 02:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbhBDH3n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 02:29:43 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B31AC061573;
        Wed,  3 Feb 2021 23:29:03 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id f1so3092037lfu.3;
        Wed, 03 Feb 2021 23:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=XTW6XCLvu1Ll2k8vkPwt+sB3B3vlqjNFERMspX4Qlhc=;
        b=h+FH8S+d2uHTg5TZ56C+GddfMlFudvAtGSOlJrwRI686KZHBEy3YjszukFMn3UbQYX
         IOr9wwuEC0QENX6iRIRYitvS/CjmbY1Qt2IUgcjBt1zzIzAIy8GDuw+yF8PUuim+0Lzv
         GvP1fM9yLAiBdaNO6ajl+kgu5xbpiULRFB03jRVL/+rIe8dYc9eIegooC0xbxrFjjPec
         u1PSd4TJDetKi03YSVtjnSDqDZU5PInaGTWfdXaNG0WYEroB2uCXYzIYyN+x6BVOgg+O
         e1hhlUc8BRymveSUrCH/xLPWWsL+++S8K1LVOP2kIK27+ywtioBssnN6DxWmTKP1U925
         SOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=XTW6XCLvu1Ll2k8vkPwt+sB3B3vlqjNFERMspX4Qlhc=;
        b=mDNysx6m08LeLbdi4kVxPWZn3ZuwRE6qxSzllnbJumEeVXWiuk4qj74w2eveW0FV47
         EtJe28d1qVyWtFqe4H8TLg8svlt5nz3M1HRwSE6xCOgnJi0+VxrVcoNIrUZyxkuE+wl/
         nJJEMXqRk7XxHsoCZT6oO9DfFWCxM4M70UJbudgInL+OU0blG9Is0dxzoZH3MkrjFo+C
         6XpZWvyxto61HlHsH7AosC/9ElWryoGTZekiuBTTipFqHHUDTTWZFd9rfMV5rNrssQ/I
         HmVBYZp/e1eaRvt5kSj9b7iu+ngZXYOXgVkn23RKf1XeFmppPX2VVejUAtJMa9R+0pdP
         sfZg==
X-Gm-Message-State: AOAM533dUuykcon53iZWNJf3tVN/b4NG3w2PgzOE/38Hg23C+Naovzaf
        ucI4hMOrwQLmkCQsDDgZn/Hx8x/lB5nxRl1ikLVdL/hVYQotlA==
X-Google-Smtp-Source: ABdhPJwNe5DjZP/tZNFGYcoB1VdvGXCsEtlBN2qb+JzjpsNr008jQ+DIEngdRsUHWD/ndkF43QjOfQUuNEZVnCTdOR4=
X-Received: by 2002:a05:6512:1311:: with SMTP id x17mr3920249lfu.307.1612423741679;
 Wed, 03 Feb 2021 23:29:01 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 4 Feb 2021 01:28:50 -0600
Message-ID: <CAH2r5mstbTOReFCejkvp0qrhjOywDUbdcO_U2wEUwatfrZ9PYA@mail.gmail.com>
Subject: [PATCH] cifs: add new helper function for fscache conversion
To:     CIFS <linux-cifs@vger.kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: multipart/mixed; boundary="00000000000059c84405ba7da8dd"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--00000000000059c84405ba7da8dd
Content-Type: text/plain; charset="UTF-8"

Add new helper to check if fscache enabled for cifs inode

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/cifs/file.c    | 7 +++++++
 fs/cifs/fscache.h | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 4b8c1ac58f00..49e7cf701b3e 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4287,6 +4287,13 @@ cifs_readpages_copy_into_pages(struct
TCP_Server_Info *server,
  return readpages_fill_pages(server, rdata, iter, iter->count);
 }

+static bool cifs_is_cache_enabled(struct inode *inode)
+{
+ struct fscache_cookie *cookie = cifs_inode_cookie(inode);
+
+ return fscache_cookie_enabled(cookie) &&
!hlist_empty(&cookie->backing_objects);
+}
+
 static int
 readpages_get_pages(struct address_space *mapping, struct list_head *page_list,
      unsigned int rsize, struct list_head *tmplist,
diff --git a/fs/cifs/fscache.h b/fs/cifs/fscache.h
index e811f2dd7619..713c0da1bad0 100644
--- a/fs/cifs/fscache.h
+++ b/fs/cifs/fscache.h
@@ -70,6 +70,10 @@ extern void
cifs_fscache_release_inode_cookie(struct inode *);
 extern void cifs_fscache_set_inode_cookie(struct inode *, struct file *);
 extern void cifs_fscache_reset_inode_cookie(struct inode *);

+static inline struct fscache_cookie *cifs_inode_cookie(struct inode *inode)
+{
+ return CIFS_I(inode)->fscache;
+}
 extern void __cifs_fscache_invalidate_page(struct page *, struct inode *);
 extern int cifs_fscache_release_page(struct page *page, gfp_t gfp);
 extern int __cifs_readpage_from_fscache(struct inode *, struct page *);
@@ -138,6 +142,7 @@ static inline void
cifs_fscache_release_inode_cookie(struct inode *inode) {}
 static inline void cifs_fscache_set_inode_cookie(struct inode *inode,
  struct file *filp) {}
 static inline void cifs_fscache_reset_inode_cookie(struct inode *inode) {}
+static inline struct fscache_cookie *cifs_inode_cookie(struct inode
*inode) { return NULL; }
 static inline int cifs_fscache_release_page(struct page *page, gfp_t gfp)
 {
  return 1; /* May release page */

-- 
Thanks,

Steve

--00000000000059c84405ba7da8dd
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-cifs-add-new-helper-function-for-fscache-conversion.patch"
Content-Disposition: attachment; 
	filename="0001-cifs-add-new-helper-function-for-fscache-conversion.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kkqjgd700>
X-Attachment-Id: f_kkqjgd700

RnJvbSAwZjk0ODhmNjhlZGJhZjYzZGI5ZjU2ZTI0MWQwMzg2ODU5MjE2MzBkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZpZCBIb3dlbGxzIDxkaG93ZWxsc0ByZWRoYXQuY29tPgpE
YXRlOiBUaHUsIDQgRmViIDIwMjEgMDE6MjM6MDQgLTA2MDAKU3ViamVjdDogW1BBVENIXSBjaWZz
OiBhZGQgbmV3IGhlbHBlciBmdW5jdGlvbiBmb3IgZnNjYWNoZSBjb252ZXJzaW9uCgpBZGQgbmV3
IGhlbHBlciB0byBjaGVjayBpZiBmc2NhY2hlIGVuYWJsZWQgZm9yIGNpZnMgaW5vZGUKClNpZ25l
ZC1vZmYtYnk6IERhdmlkIEhvd2VsbHMgPGRob3dlbGxzQHJlZGhhdC5jb20+ClNpZ25lZC1vZmYt
Ynk6IFN0ZXZlIEZyZW5jaCA8c3RmcmVuY2hAbWljcm9zb2Z0LmNvbT4KLS0tCiBmcy9jaWZzL2Zp
bGUuYyAgICB8IDcgKysrKysrKwogZnMvY2lmcy9mc2NhY2hlLmggfCA1ICsrKysrCiAyIGZpbGVz
IGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9mcy9jaWZzL2ZpbGUuYyBi
L2ZzL2NpZnMvZmlsZS5jCmluZGV4IDRiOGMxYWM1OGYwMC4uNDllN2NmNzAxYjNlIDEwMDY0NAot
LS0gYS9mcy9jaWZzL2ZpbGUuYworKysgYi9mcy9jaWZzL2ZpbGUuYwpAQCAtNDI4Nyw2ICs0Mjg3
LDEzIEBAIGNpZnNfcmVhZHBhZ2VzX2NvcHlfaW50b19wYWdlcyhzdHJ1Y3QgVENQX1NlcnZlcl9J
bmZvICpzZXJ2ZXIsCiAJcmV0dXJuIHJlYWRwYWdlc19maWxsX3BhZ2VzKHNlcnZlciwgcmRhdGEs
IGl0ZXIsIGl0ZXItPmNvdW50KTsKIH0KIAorc3RhdGljIGJvb2wgY2lmc19pc19jYWNoZV9lbmFi
bGVkKHN0cnVjdCBpbm9kZSAqaW5vZGUpCit7CisJc3RydWN0IGZzY2FjaGVfY29va2llICpjb29r
aWUgPSBjaWZzX2lub2RlX2Nvb2tpZShpbm9kZSk7CisKKwlyZXR1cm4gZnNjYWNoZV9jb29raWVf
ZW5hYmxlZChjb29raWUpICYmICFobGlzdF9lbXB0eSgmY29va2llLT5iYWNraW5nX29iamVjdHMp
OworfQorCiBzdGF0aWMgaW50CiByZWFkcGFnZXNfZ2V0X3BhZ2VzKHN0cnVjdCBhZGRyZXNzX3Nw
YWNlICptYXBwaW5nLCBzdHJ1Y3QgbGlzdF9oZWFkICpwYWdlX2xpc3QsCiAJCSAgICB1bnNpZ25l
ZCBpbnQgcnNpemUsIHN0cnVjdCBsaXN0X2hlYWQgKnRtcGxpc3QsCmRpZmYgLS1naXQgYS9mcy9j
aWZzL2ZzY2FjaGUuaCBiL2ZzL2NpZnMvZnNjYWNoZS5oCmluZGV4IGU4MTFmMmRkNzYxOS4uNzEz
YzBkYTFiYWQwIDEwMDY0NAotLS0gYS9mcy9jaWZzL2ZzY2FjaGUuaAorKysgYi9mcy9jaWZzL2Zz
Y2FjaGUuaApAQCAtNzAsNiArNzAsMTAgQEAgZXh0ZXJuIHZvaWQgY2lmc19mc2NhY2hlX3JlbGVh
c2VfaW5vZGVfY29va2llKHN0cnVjdCBpbm9kZSAqKTsKIGV4dGVybiB2b2lkIGNpZnNfZnNjYWNo
ZV9zZXRfaW5vZGVfY29va2llKHN0cnVjdCBpbm9kZSAqLCBzdHJ1Y3QgZmlsZSAqKTsKIGV4dGVy
biB2b2lkIGNpZnNfZnNjYWNoZV9yZXNldF9pbm9kZV9jb29raWUoc3RydWN0IGlub2RlICopOwog
CitzdGF0aWMgaW5saW5lIHN0cnVjdCBmc2NhY2hlX2Nvb2tpZSAqY2lmc19pbm9kZV9jb29raWUo
c3RydWN0IGlub2RlICppbm9kZSkKK3sKKwlyZXR1cm4gQ0lGU19JKGlub2RlKS0+ZnNjYWNoZTsK
K30KIGV4dGVybiB2b2lkIF9fY2lmc19mc2NhY2hlX2ludmFsaWRhdGVfcGFnZShzdHJ1Y3QgcGFn
ZSAqLCBzdHJ1Y3QgaW5vZGUgKik7CiBleHRlcm4gaW50IGNpZnNfZnNjYWNoZV9yZWxlYXNlX3Bh
Z2Uoc3RydWN0IHBhZ2UgKnBhZ2UsIGdmcF90IGdmcCk7CiBleHRlcm4gaW50IF9fY2lmc19yZWFk
cGFnZV9mcm9tX2ZzY2FjaGUoc3RydWN0IGlub2RlICosIHN0cnVjdCBwYWdlICopOwpAQCAtMTM4
LDYgKzE0Miw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBjaWZzX2ZzY2FjaGVfcmVsZWFzZV9pbm9k
ZV9jb29raWUoc3RydWN0IGlub2RlICppbm9kZSkge30KIHN0YXRpYyBpbmxpbmUgdm9pZCBjaWZz
X2ZzY2FjaGVfc2V0X2lub2RlX2Nvb2tpZShzdHJ1Y3QgaW5vZGUgKmlub2RlLAogCQkJCQkJIHN0
cnVjdCBmaWxlICpmaWxwKSB7fQogc3RhdGljIGlubGluZSB2b2lkIGNpZnNfZnNjYWNoZV9yZXNl
dF9pbm9kZV9jb29raWUoc3RydWN0IGlub2RlICppbm9kZSkge30KK3N0YXRpYyBpbmxpbmUgc3Ry
dWN0IGZzY2FjaGVfY29va2llICpjaWZzX2lub2RlX2Nvb2tpZShzdHJ1Y3QgaW5vZGUgKmlub2Rl
KSB7IHJldHVybiBOVUxMOyB9CiBzdGF0aWMgaW5saW5lIGludCBjaWZzX2ZzY2FjaGVfcmVsZWFz
ZV9wYWdlKHN0cnVjdCBwYWdlICpwYWdlLCBnZnBfdCBnZnApCiB7CiAJcmV0dXJuIDE7IC8qIE1h
eSByZWxlYXNlIHBhZ2UgKi8KLS0gCjIuMjcuMAoK
--00000000000059c84405ba7da8dd--
