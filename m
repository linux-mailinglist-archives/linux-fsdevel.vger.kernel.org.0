Return-Path: <linux-fsdevel+bounces-443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA82D7CB14A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 19:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A52E11C20865
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 17:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803FD31A80;
	Mon, 16 Oct 2023 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S317Igb0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FAA31A7A
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 17:26:39 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64C283;
	Mon, 16 Oct 2023 10:26:37 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c5028e5b88so48084161fa.3;
        Mon, 16 Oct 2023 10:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697477196; x=1698081996; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AsBurwJXbB4R5awevx162dcbGLikXeWMaEzzvRwyTNk=;
        b=S317Igb0HnsgcDGaE2FBwBcLt2Xg0DcfIocFl0iK0S/YjPld5cSo8CF4LXiI2ZiLd+
         /fNQssOT1DUyTmj0A0I5kHykSaHOfL0ts8/SV4spXIGaPaGTO1r212zGQa438YCTlOf6
         PI1/WfHcTphYD002V4LC7mHa+eKhAU8klQBhAprpakRyZfdm//vglogYx5BbevQbf6wA
         UdvrNsaWbGhl/dgXuKqHPePz7FSraud965xV7t+6GUxpRagq/eQncbINwTP7e/IiblnU
         RpmUcJ51EKQ6moVb26zsu2SQ14uNpXa/xD8o36NTUzjX1Pd0+RY6qr+Ca3N74WCNPQzA
         AJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697477196; x=1698081996;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AsBurwJXbB4R5awevx162dcbGLikXeWMaEzzvRwyTNk=;
        b=IGNXiLyDPf2BsUcvPRNWt7GhxQphNCg+zG103glm17ZEriojPylnHDjPOeclVuup+8
         g9jGFBSETZ7p6P5IGjZWAwj8KA+kV1FPHaMD7qD9+1lxbxC6X/VD2khSouO3r8rkJsMU
         1TbuTdBLUCIrmDH9Ld5/flAvTNT9oBD9VuLx2ea5vRdjqEezWBCo2RJV8cWr+XL2bLx3
         AkUjZ9BeICit/Qp054a5L8b8p0z9BqQwv7yknt7j4TiXO3bRK4r6hZIGSef8dhjZV6FQ
         1vQXnUKzE035gcGg1b3n7QXbUZHEzSC3/TkM98ZeomlROagC0NFIsavgkdwQ+2raw7Kc
         VFUg==
X-Gm-Message-State: AOJu0YyPJq1McDqn+BB24N13K1Ij3MgCAPntk8YX4UTdRPNRSYPB7jTd
	iH8XHcI1GtCJtLO4ev3Hsgx24rMX6DKXvec8b4if6pm3GW8PZQ==
X-Google-Smtp-Source: AGHT+IGgujqKyKcOrEpjXPQnPSTK+WOvMNi0lUfQFbpw2hAKHjQ6nShR1n4EuyDlQwMEWQOiKAkbAmPDk1YmkQTiPRg=
X-Received: by 2002:a2e:740e:0:b0:2c1:8a24:7afb with SMTP id
 p14-20020a2e740e000000b002c18a247afbmr29329503ljc.7.1697477195291; Mon, 16
 Oct 2023 10:26:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Mon, 16 Oct 2023 12:26:23 -0500
Message-ID: <CAH2r5mui-uk5XVnJMM2UQ40VJM5dyA=+YChGpDcLAapBTCk4kw@mail.gmail.com>
Subject: [PATCH][SMB3 client] fix touch -h of symlink
To: CIFS <linux-cifs@vger.kernel.org>
Cc: samba-technical <samba-technical@lists.samba.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000003d7e240607d8b5ee"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--0000000000003d7e240607d8b5ee
Content-Type: text/plain; charset="UTF-8"

For example:
          touch -h -t 02011200 testfile
    where testfile is a symlink would not change the timestamp, but
          touch -t 02011200 testfile
    does work to change the timestamp of the target

Looks like some symlink inode operations are missing for other fs as well

-- 
Thanks,

Steve

--0000000000003d7e240607d8b5ee
Content-Type: text/x-patch; charset="US-ASCII"; name="0001-smb3-fix-touch-h-of-symlink.patch"
Content-Disposition: attachment; 
	filename="0001-smb3-fix-touch-h-of-symlink.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lnt62yk00>
X-Attachment-Id: f_lnt62yk00

RnJvbSA2YWY1ZjgzNWJhNDk4Nzk5NGFlY2JiYTBkN2MwNjAxNjBjODkyODU2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IE1vbiwgMTYgT2N0IDIwMjMgMTI6MTg6MjMgLTA1MDAKU3ViamVjdDogW1BBVENIXSBz
bWIzOiBmaXggdG91Y2ggLWggb2Ygc3ltbGluawoKRm9yIGV4YW1wbGU6CiAgICAgIHRvdWNoIC1o
IC10IDAyMDExMjAwIHRlc3RmaWxlCndoZXJlIHRlc3RmaWxlIGlzIGEgc3ltbGluayB3b3VsZCBu
b3QgY2hhbmdlIHRoZSB0aW1lc3RhbXAsIGJ1dAogICAgICB0b3VjaCAtdCAwMjAxMTIwMCB0ZXN0
ZmlsZQpkb2VzIHdvcmsgdG8gY2hhbmdlIHRoZSB0aW1lc3RhbXAgb2YgdGhlIHRhcmdldAoKUmVw
b3J0ZWQtYnk6IE1pY2FoIFZlaWxsZXV4IDxtaWNhaC52ZWlsbGV1eEBpYmEtZ3JvdXAuY29tPgpD
bG9zZXM6IGh0dHBzOi8vYnVnemlsbGEuc2FtYmEub3JnL3Nob3dfYnVnLmNnaT9pZD0xNDQ3NgpD
YzogU3RhYmxlIDxzdGFibGVAdmdlci5rZXJuZWwub3JnPgpTaWduZWQtb2ZmLWJ5OiBTdGV2ZSBG
cmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+Ci0tLQogZnMvc21iL2NsaWVudC9jaWZzZnMu
YyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZnMv
c21iL2NsaWVudC9jaWZzZnMuYyBiL2ZzL3NtYi9jbGllbnQvY2lmc2ZzLmMKaW5kZXggMjI4Njlj
ZGExMzU2Li5lYTNhN2E2NjhiNDUgMTAwNjQ0Ci0tLSBhL2ZzL3NtYi9jbGllbnQvY2lmc2ZzLmMK
KysrIGIvZnMvc21iL2NsaWVudC9jaWZzZnMuYwpAQCAtMTE5MSw2ICsxMTkxLDcgQEAgY29uc3Qg
Y2hhciAqY2lmc19nZXRfbGluayhzdHJ1Y3QgZGVudHJ5ICpkZW50cnksIHN0cnVjdCBpbm9kZSAq
aW5vZGUsCiAKIGNvbnN0IHN0cnVjdCBpbm9kZV9vcGVyYXRpb25zIGNpZnNfc3ltbGlua19pbm9k
ZV9vcHMgPSB7CiAJLmdldF9saW5rID0gY2lmc19nZXRfbGluaywKKwkuc2V0YXR0ciA9IGNpZnNf
c2V0YXR0ciwKIAkucGVybWlzc2lvbiA9IGNpZnNfcGVybWlzc2lvbiwKIAkubGlzdHhhdHRyID0g
Y2lmc19saXN0eGF0dHIsCiB9OwotLSAKMi4zOS4yCgo=
--0000000000003d7e240607d8b5ee--

