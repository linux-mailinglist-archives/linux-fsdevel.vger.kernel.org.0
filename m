Return-Path: <linux-fsdevel+bounces-10141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEE884853B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 11:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27CB81F218EE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 10:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03ED05D8FB;
	Sat,  3 Feb 2024 10:53:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2FE5D8F1;
	Sat,  3 Feb 2024 10:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706957607; cv=none; b=lPkRsmc+eiYtm4ujj9ucxmNKfKY+FTYV9Tt4HbPaMl8elqGDQpvDYJsTurwWEx4D3wAEQ4VzdCtJ6VgC9eek5iJRvn6dbfkiQb+IL9+C1/c4sI+1ndIMv/JKULYMFmhAImkERs2ifKrZAbBV2dbVqeP1Z9+hEwnJOfl4MOw5QoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706957607; c=relaxed/simple;
	bh=bYPPmEH/ZMR+9q1jnQ+YjKiGGYzTeBfqCwewqyVwsz4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=szuqljZN0nfTW+TrGrPPJ3oE4p/iaNcj4ZRKi/3wGd+0sWyXlQphATg/RKsHmfzmOfsahYP94dYee+GJ7V4dI4iSXBlLSvVmlBzNo0u70ORrYR4SW9b7GOdeOG4ZG17ebUB35h1aGJz3yIJp8873wA7fCS8FiRw1EDNI7TmIXyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 413AqOuS052401;
	Sat, 3 Feb 2024 19:52:24 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Sat, 03 Feb 2024 19:52:24 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 413AqOqv052397
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 3 Feb 2024 19:52:24 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <8fafb8e1-b6be-4d08-945f-b464e3a396c8@I-love.SAKURA.ne.jp>
Date: Sat, 3 Feb 2024 19:52:24 +0900
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
Subject: [PATCH v2 0/3] fs/exec: remove current->in_execve flag
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This is a follow up series for removing current->in_execve flag.

https://lkml.kernel.org/r/b5a12ecd-468d-4b50-9f8c-17ae2a2560b4@I-love.SAKURA.ne.jp

[PATCH v2 1/3] LSM: add security_execve_abort() hook
[PATCH v2 2/3] tomoyo: replace current->in_execve flag with security_execve_abort() hook
[PATCH v2 3/3] fs/exec: remove current->in_execve flag

 fs/exec.c                     |    4 +---
 include/linux/lsm_hook_defs.h |    1 +
 include/linux/sched.h         |    3 ---
 include/linux/security.h      |    5 +++++
 security/security.c           |   11 +++++++++++
 security/tomoyo/tomoyo.c      |   22 ++++++----------------
 6 files changed, 24 insertions(+), 22 deletions(-)

Changes in v2:

  Replace security_bprm_aborting_creds(const struct linux_binprm *bprm) with
  security_execve_abort(void), suggested by Eric W. Biederman.

