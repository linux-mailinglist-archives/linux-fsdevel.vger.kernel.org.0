Return-Path: <linux-fsdevel+bounces-5370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5F780AE11
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 21:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6622D280E16
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 20:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152F540BEC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 20:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="Z4fson34";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cB4y2/PS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1E711D;
	Fri,  8 Dec 2023 12:04:18 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 72A563200A64;
	Fri,  8 Dec 2023 15:04:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 08 Dec 2023 15:04:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1702065855; x=1702152255; bh=GG
	NlAi0M3/WjzMXprO8Id6miZfyxGyNcpliBuJNnlBU=; b=Z4fson34NdZM6IcEu2
	iLoZagOg8lFOwUsGY7/MgxiA3LedN4e9kJA3GykFrrqKaqcQkaCw60ioeQdo5tUd
	HsdIeempYYhyj0pQcCye3E+fdHu3WaEkPkjZSkxP5Y9l7UYdMwHxtF+o0aPUuGzA
	mVqloC3lOtZUWGKLrmRkVyontchKqZFpNRxkgwT6iofNh3Rk3hYkEzp2JvQWqGG/
	fixNjBLSn7VZS4dvDpVxcoDSR7lskB75R+oOH9R1ZNW5HHvIp7qR+k2db6sj+IXi
	tHpMVAAKFuoLZW+IbRQ7h51HhzJB3hDdE18+dWI4IRKeaSdhu752YbLgrYkYaktg
	LHug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702065855; x=1702152255; bh=GGNlAi0M3/Wjz
	MXprO8Id6miZfyxGyNcpliBuJNnlBU=; b=cB4y2/PSRxjPLQFaqkfAMWDth0DBB
	3g62xpt6oL50ixWkQs8C0eBT7KLpMYa+9l86QazfOOhEMi9IM2i7tmV2qgAM4bzP
	jwCW0aSSR5QpzalgCb0thW3FgBHfZzSn0CvrS2lzLo1jOkv5U0feKE6hzvbEPoRg
	sOd920U+mOGYBDn+YB/9XQnb2M1w8j+zEuwIg+x002Mp5FbeR+RnBMVk/vrUP1Ut
	fn3wxy0VvHmuF0hecFJ35dnTfMgH4DLgrR9VCE/KKlG+EWN44kGbRn+tQM2QF2ue
	KhmgFnOzSpwSSv3GU8MXjiY/HKu9Z4AqWLcHRFf9HXprupx1rbfW8QoAw==
X-ME-Sender: <xms:v3ZzZcxZlzP9F7gZxGqFF1g-O9FKhv7tsQhhfLgBIsUCLRfVwWm4Zw>
    <xme:v3ZzZQSgJOqvPT9kXwi9Vhj3srGxLrxZW0Ylj8l_n2zXggWUKstvm0Ak871UFIXfJ
    _F9lYCmDzin7zxxvj0>
X-ME-Received: <xmr:v3ZzZeURbIzstxM83ZJB7wN38bM_adx6KXAa5wCUDSD-oWbr3xQ_7Vjp6_4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekiedgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigt
    hhhoucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtf
    frrghtthgvrhhnpeelveduteeghfehkeeukefhudfftefhheetfedthfevgfetleevvddu
    veetueefheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthihtghhohesthihtghhohdrphhi
    iiiirg
X-ME-Proxy: <xmx:v3ZzZajIFjxXuK0OpO2WXKzSOnk9R9-7QodwrzuEBDBt26kwkGDrgA>
    <xmx:v3ZzZeAjHvXt8Ks21zhawShfuuHJwmwjrYixTHE-wiqfE1FSct7FsQ>
    <xmx:v3ZzZbIid0UApEmFYARIYTY-EYrG66b-E0OQhspWscn2cMiinwlerg>
    <xmx:v3ZzZUAzxrDhTBWo8ThOoC7WjBbnJPx-KCkgtSdl9JjfjfFTcr6Ebg>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Dec 2023 15:04:13 -0500 (EST)
Date: Fri, 8 Dec 2023 13:04:11 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [RFC 1/3] pidfd: allow pidfd_open() on non-thread-group leaders
Message-ID: <ZXN2u2oJl1Z6FTqt@tycho.pizza>
References: <20231130163946.277502-1-tycho@tycho.pizza>
 <20231130173938.GA21808@redhat.com>
 <ZWjM6trZ6uw6yBza@tycho.pizza>
 <ZWoKbHJ0152tiGeD@tycho.pizza>
 <20231207-weither-autopilot-8daee206e6c5@brauner>
 <20231207-avancieren-unbezahlbar-9258f45ec3ec@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207-avancieren-unbezahlbar-9258f45ec3ec@brauner>

On Thu, Dec 07, 2023 at 10:25:09PM +0100, Christian Brauner wrote:
> > If these concerns are correct
> 
> So, ok. I misremebered this. The scenario I had been thinking of is
> basically the following.
> 
> We have a thread-group with thread-group leader 1234 and a thread with
> 4567 in that thread-group. Assume current thread-group leader is tsk1
> and the non-thread-group leader is tsk2. tsk1 uses struct pid *tg_pid
> and tsk2 uses struct pid *t_pid. The struct pids look like this after
> creation of both thread-group leader tsk1 and thread tsk2:
> 
> 	TGID 1234				TID 4567 
> 	tg_pid[PIDTYPE_PID]  = tsk1		t_pid[PIDTYPE_PID]  = tsk2
> 	tg_pid[PIDTYPE_TGID] = tsk1		t_pid[PIDTYPE_TGID] = NULL
> 
> IOW, tsk2's struct pid has never been used as a thread-group leader and
> thus PIDTYPE_TGID is NULL. Now assume someone does create pidfds for
> tsk1 and for tsk2:
> 	
> 	tg_pidfd = pidfd_open(tsk1)		t_pidfd = pidfd_open(tsk2)
> 	-> tg_pidfd->private_data = tg_pid	-> t_pidfd->private_data = t_pid
> 
> So we stash away struct pid *tg_pid for a pidfd_open() on tsk1 and we
> stash away struct pid *t_pid for a pidfd_open() on tsk2.
> 
> If we wait on that task via P_PIDFD we get:
> 
> 				/* waiting through pidfd */
> 	waitid(P_PIDFD, tg_pidfd)		waitid(P_PIDFD, t_pidfd)
> 	tg_pid[PIDTYPE_TGID] == tsk1		t_pid[PIDTYPE_TGID] == NULL
> 	=> succeeds				=> fails
> 
> Because struct pid *tg_pid is used a thread-group leader struct pid we
> can wait on that tsk1. But we can't via the non-thread-group leader
> pidfd because the struct pid *t_pid has never been used as a
> thread-group leader.
> 
> Now assume, t_pid exec's and the struct pids are transfered. IIRC, we
> get:
> 
> 	tg_pid[PIDTYPE_PID]   = tsk2		t_pid[PIDTYPE_PID]   = tsk1
> 	tg_pid[PIDTYPE_TGID]  = tsk2		t_pid[PIDTYPE_TGID]  = NULL
> 
> If we wait on that task via P_PIDFD we get:
> 	
> 				/* waiting through pidfd */
> 	waitid(P_PIDFD, tg_pidfd)		waitid(P_PIDFD, t_pid)
> 	tg_pid[PIDTYPE_TGID] == tsk2		t_pid[PIDTYPE_TGID] == NULL
> 	=> succeeds				=> fails
> 
> Which is what we want. So effectively this should all work and I
> misremembered the struct pid linkage. So afaict we don't even have a
> problem here which is great.

It sounds like we need some tests for waitpid() directly though, to
ensure the semantics stay stable. I can add those and send a v3,
assuming the location of do_notify_pidfd() looks ok to you in v2:

https://lore.kernel.org/all/20231207170946.130823-1-tycho@tycho.pizza/

Tycho

