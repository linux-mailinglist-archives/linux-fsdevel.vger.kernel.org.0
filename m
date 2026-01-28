Return-Path: <linux-fsdevel+bounces-75720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOPJAGMOemmS2AEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 14:25:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96995A216F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 14:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0592830136A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 13:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4229C352FA1;
	Wed, 28 Jan 2026 13:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gchs8YhE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AB62F0C45
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 13:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769606650; cv=none; b=Rza68lUuvGh/DRLjjtZWRPUHvVpkZk2JQCQ+ir70qaKFf45ehUFNM/aW2NSPyaApwTRMVr9N/DxVm5UCDIrQmym5UrW6JGjvT20wu0BruVa8A0yA7yYQKiowgYlJb4Ff/MBrXCgd4Noc9fH4wg+3X85U2aDHsGLrz0H1CiO4M1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769606650; c=relaxed/simple;
	bh=5mj9f+jiqWsP8JUwxAFNqRoV0N/RWg4pBZ79Q5rxyLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IAjCMiqvUR+7WO4/cpM+ygFDlwa7u0R7jYGHeXGLAsAAKazZgYk3F0cJv7Gv7AMDUPjFYFD1ePe2GX6CPDSTWZ18UPKS7WipS8JDMawCF5UeWe60YLVQOuyKmXVpJHOg+PkJNYEqRHFboZ4x35u23faanaTJOT8kEXJha4VZ21s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gchs8YhE; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6581327d6baso10528529a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 05:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769606648; x=1770211448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2C0U7hvt67M0jhge/Mq6BbLukFcgthoPBAq2udkVqlA=;
        b=Gchs8YhEuiqjm7UISgnUjThDUVDjst+urDIUMDvEB+B31Ai5cUSrRb3Qd2uWZnojlA
         jE+uY/UYXdxaPhQKj/vTQbpygTlD6GYbeszZyAkIXsAVkFM5/Ludp+69wuF/CPmwGDIn
         9wcjCFDjXBrziTjElQLGG3RzWEsLb2yFOUPYOAWyEUQzyUQy0Op9Rc7Fk+TXyO4mtgPK
         6jcVnDRPs5m5BO9Fylo0AQQKDS6x40LuSQ2PN7p6JI4w/1QjvWFydOFjAP7Jh8RFkX5H
         Alb/TM8kxyD3Nhr402gfxfnZpwW5YN9Xmx04SRjjheRMSckdoA/tyQZrWuIZ3B2Q+sDn
         NWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769606648; x=1770211448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2C0U7hvt67M0jhge/Mq6BbLukFcgthoPBAq2udkVqlA=;
        b=pUO+QaOXXFrApyVaGUJbQx/vhf2GhAL8iJZog+MpZGQ9e4j4i9kDGMOVKfrU+zyL0+
         9NLVdcK2BKpeJ9gkpGLMFxy4sg3aPdYkM6/FUCcSD27pKzzeG01ZRyc7keKhP/N8fzrG
         QJ6yKG9CtJ3RcR5KpSFENc7ewVrSLhQ+F5u+2JTxWjGlmS9dcxS61g0biOGY4P71O07Y
         y4TVgxY8pdKfDuvPZY+nCobP+TFYqPUK+qEFx1+Z9JzTW6cyS+j6MYmTMNgz5JExTGOA
         R4Ns8W8eU+XyygtKjVw6RjRseRO7AbSHs7mS7tGj3klG9HNfk9AryQjhQUIWeAquAQVk
         JLUg==
X-Forwarded-Encrypted: i=1; AJvYcCWTETOGyQGh+fi0lZ9FN03+xu0ldnrvjR+EOJL0zREYyo8TRMUcmO5ppT9YyZV+q3BXTf/OVNPeHdfKJY6v@vger.kernel.org
X-Gm-Message-State: AOJu0YxHE4qpZp//zEt1n+K4JbfPELvigwWWhKu2+PI183ZHgZvDBfRj
	Jey8p21XTL8cbTUApffTxk3bbXMTAQS0AIs6ZPAaja7UdNIGReqxNb9C
X-Gm-Gg: AZuq6aLY6lkK9eXb69BNl7SIAfktYSU0jPHSb1CTYUGaBLoXblPUfYLH2FtHic8xhN/
	FeEgDnrk5uEAMrurawLqvBTvEHYlUExaPz/T3jtSojsDO/Xz8m3r8ZSzv9eBmKItHfblVwNA0w8
	OUqRdTXprohjJWpz3dr+bc/42JMkB/eaP80mt6x4wjsx6kArIy9iQ0aVaGmc99V8wfb7tjyfhMF
	pdwmVEiBjDsKWR1mW7ZWmamEK6YUPLqbDLaxdZLXM+b0FYdreoVuhJf7S/4Q8sr4mB3FmwSo3IF
	UwJI6eRjPCOAH3j3F3wiiaPYvmNpXztApZOc1mD5Y5pWeaY2xBTe/CbdZfdSsJx/poxQsW2QVOx
	bZw7YZs0GZ5sH26xc8Th3PrskbSzux1ONRoWP3yXmJo8qxbClIYQsH9rxsBa0qg55qiq8vHTo27
	KSv/SgB9zr6FPOrDSZd62d7ztKwpUpFXeUO+9ClvOpn5WW3oklfFJA50UPDPBKR8W4B3mRErP/A
	cAk7oFyanShJw15
X-Received: by 2002:a05:6402:430a:b0:658:b922:22e0 with SMTP id 4fb4d7f45d1cf-658b922246emr1251224a12.28.1769606647432;
        Wed, 28 Jan 2026 05:24:07 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-c84e-f30e-bdab-df5a.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:c84e:f30e:bdab:df5a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b4691d0asm1545885a12.18.2026.01.28.05.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 05:24:06 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>
Cc: Qing Wang <wangqing7171@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [PATCH 0/3] name_is_dot* cleanup
Date: Wed, 28 Jan 2026 14:24:03 +0100
Message-ID: <20260128132406.23768-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75720-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 96995A216F
X-Rspamd-Action: no action

Miklos,

Following the syzbot ovl bug report and a fix by Qing Wang,
I decided to follow up with a small vfs cleanup of some
open coded version of checking "." and ".." name in readdir.

The fix patch is applied at the start of this cleanup series to allow
for easy backporting, but it is not an urgent fix so I don't think
there is a need to fast track it.

Christian,

I am assuming that you would want to take the vfs cleanup
via your tree, so might as well take the ovl adjacent patches
with it.

If you want me to drive this entire series via ovl tree, please
ack the vfs cleanup patch.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-unionfs/20260127105248.1485922-1-wangqing7171@gmail.com/

Amir Goldstein (2):
  fs: add helpers name_is_dot{,dot,_dotdot}
  ovl: use name_is_dot* helpers in readdir code

Qing Wang (1):
  ovl: Fix uninit-value in ovl_fill_real

 fs/crypto/fname.c      |  2 +-
 fs/ecryptfs/crypto.c   |  2 +-
 fs/exportfs/expfs.c    |  3 ++-
 fs/f2fs/dir.c          |  2 +-
 fs/f2fs/hash.c         |  2 +-
 fs/namei.c             |  2 +-
 fs/overlayfs/readdir.c | 39 +++++++++++++++------------------------
 fs/smb/server/vfs.c    |  2 +-
 include/linux/fs.h     | 14 ++++++++++++--
 9 files changed, 35 insertions(+), 33 deletions(-)

-- 
2.52.0


