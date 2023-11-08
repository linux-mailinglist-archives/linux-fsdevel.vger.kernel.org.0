Return-Path: <linux-fsdevel+bounces-2442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7857E5F96
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 22:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8655B20F4B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 21:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B088C374CA;
	Wed,  8 Nov 2023 21:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="OBkY462g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PE2aMCi9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEC537175;
	Wed,  8 Nov 2023 21:01:50 +0000 (UTC)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6480EA;
	Wed,  8 Nov 2023 13:01:49 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 9574F320070D;
	Wed,  8 Nov 2023 16:01:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 08 Nov 2023 16:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1699477306; x=1699563706; bh=og
	I1vY/TtmrKblm9hj+bYsj8vQ85H0nx7k7sJd7Rhtk=; b=OBkY462gYQf2gf9BYY
	vVTtN71ATZPF6QPw2Oa+9zbuyJ1/uFPuGyzPjgJXcJiQX1qVFextvtO0eknB5unB
	eIZjj0hCCLX10p4J5SEVOn+9jwWq1j/Ah8OWE3pW80PgImabRmwgsy22TFKJ+NRX
	VgDkOcWrq2UTK8DVBTqmmjiZxnt9o1MkZnCitqZZug7luwqiGnmaofdiNlTGxYeT
	rVhG0ZOobBX+QTphF8igSnh3ZSwYWetwZ2FV++3RwfkWw0FymZDzeJtMPJjmaMDR
	ZAE+pzzn3yqlO37nVrVEYESCS59JrRlWuvHqQs9Fm/P4BVcIr7bbcypTmqlxzCwz
	Eh4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1699477306; x=1699563706; bh=ogI1vY/TtmrKb
	lm9hj+bYsj8vQ85H0nx7k7sJd7Rhtk=; b=PE2aMCi95WYigB9jqQ1OmvkELT+69
	K3aJjlpl1AuRnOj7/VCf+AhzqzaJJHqPBSXuVEf++TGG0DYpfPu8l9EK5vbd+X2Y
	vq6HidCDPD4ckHDE5do+rZhkSq/6u5ttonp7qX0jux2vLgj4Wo8T+VgqvzHXhUbY
	yuFI9AsrfH8UjPQAcwbZeB8ii3xilWd7v2u5x0SFpIjLSc26svziKlvbCJMJqTaU
	3sWmx3Gx5RL6ba/tbtpwniJQbRAvDLgHObriXBfuj1Ymt5lderDo3vHyiHcKM67u
	uJ1OIm3J47KcQGlzJydsp3hdXWgSQ7geHO/ciMhFFPcKCVOy6ugL2246Q==
X-ME-Sender: <xms:OPdLZSv8-HtQ2b0hxbGYJnX4aYoAv_igfHRbx6mWP4otlN8JBIcctA>
    <xme:OPdLZXccLIUs85bedOCiW6uyGe62SQiH3g8-HVPb2m8PjcwUY26HLdchQpGEhOFGW
    eRjWDXOqI2_Ur6pXT8>
X-ME-Received: <xmr:OPdLZdxgb7xV4ZirDtU7iR1b8dr_mGDaKEFNv5PbuMudOrwrO9yi3Rqbugg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduledgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigt
    hhhoucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtf
    frrghtthgvrhhnpeeutedttefgjeefffehffffkeejueevieefudelgeejuddtfeffteek
    lefhleelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:OPdLZdNRJaTe160IaBVULj1TS4jBuNCr7GuaE4xuoRB--WvZhqYH-A>
    <xmx:OPdLZS8tLxAAUk2hBwjaCpcqru4a6HvG5RaM_5kCYPiqAUwc6OPaOg>
    <xmx:OPdLZVUT6TDzDlg_fIZM3KSg4Y9qLBDjq_h8JKaw8sZt4MOhZqxDfA>
    <xmx:OvdLZWQ4aFJSfc0q_Eyy3yqGptMPQA1UCj29-BMq622zynHaDrqs0g>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Nov 2023 16:01:42 -0500 (EST)
Date: Wed, 8 Nov 2023 14:01:40 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Haitao Huang <haitao.huang@linux.intel.com>,
	Kamalesh Babulal <kamalesh.babulal@oracle.com>,
	Tycho Andersen <tandersen@netflix.com>
Subject: Re: [RFC 4/6] misc cgroup: introduce an fd counter
Message-ID: <ZUv3NCZjRn5zfytj@tycho.pizza>
References: <20231108002647.73784-1-tycho@tycho.pizza>
 <20231108002647.73784-5-tycho@tycho.pizza>
 <20231108165749.GY1957730@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108165749.GY1957730@ZenIV>

Hi Al,

Thanks for looking. Somehow I also missed CCing you, whoops,

On Wed, Nov 08, 2023 at 04:57:49PM +0000, Al Viro wrote:
> On Tue, Nov 07, 2023 at 05:26:45PM -0700, Tycho Andersen wrote:
> 
> > +	if (!charge_current_fds(newf, count_open_files(new_fdt)))
> > +		return newf;
> 
> Are you sure that on configs that are not cgroup-infested compiler
> will figure out that count_open_files() would have no side effects
> and doesn't need to be evaluated?
> 
> Incidentally, since you are adding your charge/uncharge stuff on each
> allocation/freeing, why not simply maintain an accurate counter, cgroup or
> no cgroup?  IDGI...  Make it an inlined helper right there in fs/file.c,
> doing increment/decrement and, conditional upon config, calling
> the cgroup side of things.  No need to look at fdt, etc. outside
> of fs/file.c either - the counter can be picked right from the
> files_struct...

Thanks, I can re-work it to look like this.

> >  static void __put_unused_fd(struct files_struct *files, unsigned int fd)
> >  {
> >  	struct fdtable *fdt = files_fdtable(files);
> > +	if (test_bit(fd, fdt->open_fds))
> > +		uncharge_current_fds(files, 1);
> 
> Umm...  Just where do we call it without the bit in ->open_fds set?
> Any such caller would be a serious bug; suppose you are trying to
> call __put_unused_fd(files, N) while N is not in open_fds.  Just before
> your call another thread grabs a descriptor and picks N.  Resulting
> state won't be pretty, especially if right *after* your call the
> third thread also asks for a descriptor - and also gets N.
> 
> Sure, you have an exclusion on ->file_lock, but AFAICS all callers
> are under it and in all callers except for put_unused_fd() we
> have just observed a non-NULL file reference in ->fd[N]; that
> would *definitely* be a hard constraint violation if it ever
> happened with N not in ->open_fds at that moment.
> 
> So the only possibility would be a broken caller of put_unused_fd(),
> and any such would be a serious bug.
> 
> Details, please - have you ever observed that?

No, I just kept it from the original series. I agree that it should be
safe to drop.

> BTW, what about the locking hierarchy?  In the current tree ->files_lock
> nests inside of everything; what happens with your patches in place?

If I understand correctly you're asking about ->files_lock nesting
inside of task_lock()? I tried to make the cgroup side in this patch
do the same thing in the same order. Or am I misunderstanding?

I did test this with some production container traffic and didn't see
anything too strange, but no doubt there are complicated edge cases
here.

Thanks,

Tycho

