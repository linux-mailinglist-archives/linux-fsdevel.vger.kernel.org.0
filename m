Return-Path: <linux-fsdevel+bounces-9239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5374783F5BF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 15:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85AC71C2255D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 14:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036A5241EC;
	Sun, 28 Jan 2024 14:17:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BF023777;
	Sun, 28 Jan 2024 14:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706451431; cv=none; b=QYAsvrqTz1jqsK0WUVYEbovO44GsyEnjmnN83kGxpm/PgdWw1Vf6DyM+E83auvDRHfzl7H/qnu1U7NTfKhc5lY2w6Tzy0OFcwBOuC9BFFDn15UosANae7Yiklkewk7RQ/yFPdeMvkLPuzMa+h1X79HFteVeWOrk4rqt3RulM0VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706451431; c=relaxed/simple;
	bh=Lvpoe4XPv399MibOZjtFz+LUCvhA8WJTDLiCKbsxhfQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=JI6MuwSreqeKOCyZ3Ul6nOGLayiu6E2sAvzeeZMKVB+j/BIdya77eb3ZrjdzioF8kt/dbsMRWm2YS2wQvbwb9uhwiTch1LTgt+/Jn/enbtgCtV/JwyZRXbm/9fhIY/MG1lYFRNZAH4tF7L+GeUvoQ35PvarDkeBwKHtZ2ENVsJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 40SEGBKf024137;
	Sun, 28 Jan 2024 23:16:11 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Sun, 28 Jan 2024 23:16:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 40SEGAAV024134
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 28 Jan 2024 23:16:10 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e938c37b-d615-4be4-a2da-02b904b7072f@I-love.SAKURA.ne.jp>
Date: Sun, 28 Jan 2024 23:16:09 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 0/3] fs/exec: remove current->in_execve flag
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This is a follow up series for removing current->in_execve flag.

https://lkml.kernel.org/r/b5a12ecd-468d-4b50-9f8c-17ae2a2560b4@I-love.SAKURA.ne.jp

[PATCH 1/3] LSM: add security_bprm_aborting_creds() hook
[PATCH 2/3] tomoyo: replace current->in_execve flag with security_bprm_aborting_creds() hook
[PATCH 3/3] fs/exec: remove current->in_execve flag

 fs/exec.c                     |    4 +---
 include/linux/lsm_hook_defs.h |    1 +
 include/linux/sched.h         |    3 ---
 include/linux/security.h      |    5 +++++
 security/security.c           |   14 ++++++++++++++
 security/tomoyo/tomoyo.c      |   22 ++++++----------------
 6 files changed, 27 insertions(+), 22 deletions(-)

(Please apply directly to linux.git tree if this series is OK, for
 currently TOMOYO's tree is unavailable.)

