Return-Path: <linux-fsdevel+bounces-76646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMZ8NuROhmlpLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 21:28:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D77E1031A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 21:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08F343043D72
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 20:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5601B30E0E4;
	Fri,  6 Feb 2026 20:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="PBvyIfw2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3D92E175F
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 20:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770409692; cv=none; b=b2qS+lmAWIX0yh26Fg2b+I1bPeCzWg3mNr6iv+OjPCgJV8KUSw+dyQyUrJnLJSiiPLb/e6u/iRUBVvpMVmNJkluk7NDnOMNthyiGAhTUDwDfAxzZcWacilvw1wwqXTdaaqEcwwKYVKUcBbHHkYbxGfTi+FiOYxvDKUTSAlb0bqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770409692; c=relaxed/simple;
	bh=Z5aaRmSOHMFDbg6CPFROQyFYr03jewWVqkDMdJPuzkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=emHi1OXi8VrubleldaFI25rHlzmz+JJPZOGFWSoI9B3b8ssRQp5MQWK7+lay5X3IHtWlQpr/46ii5xpD2kSRIBmSp1VWBSSgO9SKl+1jg4UVCmLHpZPPK7OYeh2eDYeIfBu5MvVQzpwEU6jpgqkY6q/bFYocYQ73wIaeqEwbRW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=PBvyIfw2; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-794e0e933ccso12819197b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Feb 2026 12:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1770409691; x=1771014491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0qkRyjYepm1vL8YsOB5hZZCuF7RL4gTgPwCwUHAKKtc=;
        b=PBvyIfw2kN1mJt1xHQCqZY3uauH58zenIDVzpd6QT274FAcRRyX6HYzvxYfXEvSqUZ
         OZ+WLYr6a0npnw5YDoKZ7oQhqUQG40I9FqhxfbR+fG4IPyV+wnUgeV97pFmawfBWCvPB
         SLEr7LvKhhav3s0zZ0wReXaOYTqTGBJsXxNWTX187L/mtYpgSS+hpe4dG9mcZMOWlr7I
         Ef2D7vHnZ+JyZu/TKMYGN0XhfYKRuzAIePDDtEzb04AIb75Y5jHC189V0FxPzcztUj90
         XKJjt5IKamj4KA/LPMhYyLC0lpYOLXtgGaAPl2abtQrrPLIOdEBAXUOijfWgNdgtiBPf
         MGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770409691; x=1771014491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qkRyjYepm1vL8YsOB5hZZCuF7RL4gTgPwCwUHAKKtc=;
        b=V+U3rmKIvWHyp83g2fB11aFwcnsOUdbvjK28opi5hEJeGzyEUUJCDCjusLKnv9a/YP
         9vGNGBUk9kjg2vFY1ImG0qwG5ky1fM861CaLv9cPR5ZHC/C9YGt3ryGBejZDo10YlLcF
         XGch9QzGCz/WJc+rFxgfKF0G81RQ+xYqYHSiBUPAG3l9L7oAVy29VBDtftS9NFaTw2is
         XFJA0S4L6WEjyv5CeLDTEIlGSAxWGe89juDISjNDuuwYGf/oKJbw4ye2cyATkjzLkOfw
         Hag5xrgA8KG2Z8+rs4c4whq+B2o7UxEB+yO0eWzDJtUjOObOQRQEsu4AuhwI3j6FIHOh
         tMGg==
X-Forwarded-Encrypted: i=1; AJvYcCW6XXmiayy9nbplVHrHNtCa4RBfkMxjP7Xg+u1mngxMbyNUTW7oYUI1v3feT8IQT93CJOCh2AjPK5Xqgwv0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw02wSEHEogRnknwH62gXx+2mpXU/r+cU0aFWrzRd8IeGiBhJKr
	5gLlmlH4GrWbt5S4X6CzIZpVz5tLnbgwaBC3tbU3KDIgmcF1cuXJN8BUITkw1tEc5hQ=
X-Gm-Gg: AZuq6aJALMflldzCfKprWOZnalS9ZW9IVSIG577LlZV/8oQ67Ij1uIpqfWf7AC5YnBo
	HhfsuNwXqGS1wUO4KMtJ0es1Z3ayvRgTcU7IyMPYBV62XItpUPYt11VlUpF9RbXFVJsGcDqryX6
	igtCBi2FQZcna+Z29l5yiPfvyUwcBHd+15+DgtUXJJzy9srfNe6lIyGxzWK2J4kao26TkM4LcFw
	aLhSwjvFD4CzkwBOEh9RUNt6udGqsT4Ix/IfFAS7ohPNwfMEjmJcb/wcR90YT4CuwuZHMgTiqzs
	ooBm0R0dhtyob36Zz5NwyvKf4JUL4hOGz+lApQiMs1MdxPx51mtLtmDeO+CvzKbxE7kyQhxipHZ
	C9Uc8YK5YjYKiqWEBDJtrOHi7TMz6OM6f0fTC8GcAfY/Zk3L2z+QHCOq3hs1Cwo0atJgYiLr/jJ
	5C6lhemaKj02KOcBOeB4LLVzvVmNGZaIrcpgKFsiG++j+z6BY2ofo8I21iEZGGWxmKAmb61GVI7
	wm7B3I3+wHlgRB1nvI=
X-Received: by 2002:a05:690c:91:b0:795:795:d8e3 with SMTP id 00721157ae682-7952ababb6cmr40484477b3.70.1770409691543;
        Fri, 06 Feb 2026 12:28:11 -0800 (PST)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:a0a1:736b:295e:2ad8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7952a2348c1sm31069507b3.38.2026.02.06.12.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 12:28:10 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [PATCH] ceph: fix generic/639 xfstests failure
Date: Fri,  6 Feb 2026 12:27:58 -0800
Message-ID: <20260206202757.1535351-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[dubeyko-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76646-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[dubeyko-com.20230601.gappssmtp.com:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,redhat.com,ibm.com,dubeyko.com];
	DMARC_NA(0.00)[dubeyko.com];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slava@dubeyko.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dubeyko.com:mid,dubeyko-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 4D77E1031A1
X-Rspamd-Action: no action

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

The generic/639 xfstest fails for Ceph msgr2 protocol:

Ubuntu 22.04.5 LTS (GNU/Linux 6.17.0-rc7+ x86_64)

sudo mount -t ceph :/ /mnt/cephfs/ -o name=admin,fs=cephfs,ms_mode=secure

sudo ./check generic/639
FSTYP -- ceph
PLATFORM -- Linux/x86_64 ceph-0005 6.17.0-rc7+ #16 SMP PREEMPT_DYNAMIC Wed Nov 12 11:01:48 PST 2025
MKFS_OPTIONS -- 192.168.1.213:3300:/scratch
MOUNT_OPTIONS -- -o name=admin,ms_mode=secure 192.168.1.213:3300:/scratch /mnt/cephfs/scratch

generic/639 - output mismatch (see /home/slavad/XFSTESTS-2/xfstests-dev/results//generic/639.out.bad)

The simple way to reproduce the issue simply running these steps:

mount -t ceph :/ /mnt/cephfs/ -o name=admin,fs=cephfs,ms_mode=secure
xfs_io -f -c "pwrite -q 0 32" ./testfile251125-0004
umount /mnt/cephfs/
mount -t ceph :/ /mnt/cephfs/ -o name=admin,fs=cephfs,ms_mode=secure
xfs_io -c "pwrite -q 32 32" ./testfile251125-0004

Finally, we have the unexpected content of the file:

hexdump ./testfile251125-0004
0000000 0000 0000 0000 0000 0000 0000 0000 0000
*
0000020 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
*
0000040

Initial analysis has shown that if we try to write out of
end of file, then ceph_write_begin() is responsible for
the issue because it calls netfs_write_begin() and we have
such logic:

int netfs_write_begin(struct netfs_inode *ctx,
              struct file *file, struct address_space *mapping,
              loff_t pos, unsigned int len, struct folio **_folio,
              void **_fsdata)
{
<skipped>

    folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
                    mapping_gfp_mask(mapping));

<skipped>

    if (folio_test_uptodate(folio))
        goto have_folio;

<skipped>
}

The reason of the issue that somehow we have folio in uptodate
state and netfs_write_begin() simply skips the logic of
reading existing file's content.

Futher analysis revealed that we call ceph_fill_inode() and
ceph_fill_inline_data() before ceph_write_begin().

void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
               char    *data, size_t len)
{
<skipped>

    if (page != locked_page) {
        if (len < PAGE_SIZE)
            zero_user_segment(page, len, PAGE_SIZE);
        else
            flush_dcache_page(page);

        SetPageUptodate(page); <--- We set page uptodate if len == 0!!!!
        unlock_page(page);
        put_page(page);
    }
}

This patch fixes the issue by checking the len argument and
setting memory page uptodate only if len > 0.

sudo ./check generic/639
FSTYP         -- ceph
PLATFORM      -- Linux/x86_64 ceph-0005 6.19.0-rc5+ #2 SMP PREEMPT_DYNAMIC Thu Feb  5 15:43:51 PST 2026
MKFS_OPTIONS  -- 192.168.1.213:3300:/scratch
MOUNT_OPTIONS -- -o name=admin,ms_mode=secure 192.168.1.213:3300:/scratch /mnt/cephfs/scratch

generic/639 6s ...  6s
Ran: generic/639
Passed all 1 tests

[1] https://tracker.ceph.com/issues/73829

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Patrick Donnelly <pdonnell@redhat.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 fs/ceph/addr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 63b75d214210..436a287fd311 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -2184,7 +2184,9 @@ void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
 		else
 			flush_dcache_page(page);
 
-		SetPageUptodate(page);
+		if (len > 0)
+			SetPageUptodate(page);
+
 		unlock_page(page);
 		put_page(page);
 	}
-- 
2.53.0


