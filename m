Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0653ECE8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 08:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbhHPGUs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 02:20:48 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:44145 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229774AbhHPGUs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 02:20:48 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 54A722B01164;
        Mon, 16 Aug 2021 02:20:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 16 Aug 2021 02:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=zAhcmoFeElgK3R417Gl8Vdkr7ur
        r8yT41iKEe+enZr4=; b=djYWA5WiaNiydcMcKdOfh/wXCjq+ArKRzHl/0OOfhTM
        jgYt9WNL2SomPv2wJ/I4iD7jZ/yEdvEcKn0ciI1GHSUV9oV1ZgOXycbBcWlPhDSp
        zUawZG7SzJm8Z4JXYy+/T95+pE1bLD/d+YUh0f4MdWBEMD4BXB+qWalPGPYGrRvq
        6F+nsfAAS1h0MQZKlfsSsEgVJgY5ni06aPUX4qFk6cIdrqVgWYtbejpZxTn8BHcz
        4y/4V7FyRnK+yBEgC1lHirgXNyThOdJ/ZLgo9irkhX5Xh4UJw1MJYtV98Ps4dV0/
        tUtgrDZ/1HLJH3m30v8KFvHNAF4toGqT0eJF77vwcUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=zAhcmo
        FeElgK3R417Gl8Vdkr7urr8yT41iKEe+enZr4=; b=gbLMaSpSTLXHaNsruyMh5o
        yfL+5b6yKn91H7AekAM9u2h0uye9ZuDb5Yd3lUjXXV+jTTU5SeJ+fA6/pLqH0uFn
        oQqiOkR/nOohs2hbic0BWENL24qzU3+6aQP+xC4nrf9r6V4USd48hYRd/8/Wdd7G
        EcLZwZMQzUavib+UWGbWCnPPDDzl8Vz3RgeBWlkq8GKFpVv7ldvs+L87fg7aA6Xp
        dqQf/ncJPZMi82I/C7MzHn1233/bPZCe4jo8Qdv7oIZwc5rVqU4XZ3NenxCGujT7
        mFO3/LqeYvLuGzE948CwRF+C696Hgf/eTLR9sLLUCP3EaycDFLz5vynBRD+1lC5g
        ==
X-ME-Sender: <xms:nwMaYUPCn5v7Njbt3azN3VyrLRQy9l53B12BSEGxqsqnZ2DjLB9kZA>
    <xme:nwMaYa8ESEMBFh8bG6l0QWbiV5aUd9WVEkCheBfVkXMMi0Oixk662j2PGCbmdHbIM
    dZe91ZPit5_kg>
X-ME-Received: <xmr:nwMaYbSQk2SnarektIuobI-i4i0vqfLoxiSqhHh1ysle5FOHCdvzlhZUmsC4CLy8r9brZsDSfWqctpMeWhwlfXbTQlTluX0Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrledtgddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepveeuheejgfffgfeivddukedvkedtleelleeghfeljeeiue
    eggeevueduudekvdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:nwMaYcvAqSlxbWgCzjZ8bgkMz6qJsXgZjfSlmAmOvSA0cxiqEvKnVQ>
    <xmx:nwMaYcc85UHVT1PGkoQBZzXNoLnNZEv-6KscJLzFQ9O8C7letBkH5g>
    <xmx:nwMaYQ1HkB0YYyJCbWbpGBNONkL4SwocYin-m2ad69nTvRsQ0UGANg>
    <xmx:nwMaYS2itS4bAunB7bQK9C47H3adcmUAbQISwLnm0cSlqcAV9sK3IjCJ-Wk>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Aug 2021 02:20:14 -0400 (EDT)
Date:   Mon, 16 Aug 2021 08:20:11 +0200
From:   Greg KH <greg@kroah.com>
To:     Itay Iellin <ieitayie@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linuxfoundation.org,
        ebiederm@xmission.com, security@kernel.org,
        viro@zeniv.linux.org.uk, jannh@google.com
Subject: Re: fs/binfmt_elf: Integer Overflow vulnerability report
Message-ID: <YRoDm2emnm0VEgj/@kroah.com>
References: <YRnun9418g70VyJT@itaypc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRnun9418g70VyJT@itaypc>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 16, 2021 at 07:50:39AM +0300, Itay Iellin wrote:
> Bcc: 
> Subject: fs/binfmt_elf: Integer Overflow vulnerability report
> Reply-To: 
> I'm sharing a report of an integer overflow vulnerability I found (in 
> fs/binfmt_elf.c). I sent and discussed this vulnerability report with members
> of security@kernel.org. I'm raising this for public discussion, with approval
> from Greg (greg@kroah.com).
> 
> On Sun, Aug 01, 2021 at 04:30:30PM +0300, Itay Iellin wrote:
> > In fs/binfmt_elf.c, line 1193, e_entry value can be overflowed. This
> > potentially allows to create a fake entry point field for an ELF file.
> > 
> > The local variable e_entry is set to elf_ex->e_entry + load_bias.
> > Given an ET_DYN ELF file, without a PT_INTERP program header, with an 
> > elf_ex->e_entry field in the ELF header, which equals to
> > 0xffffffffffffffff(in x86_64 for example), and a load_bias which is greater 
> > than 0, e_entry(the local variable) overflows. This bypasses the check of 
> > BAD_ADDR macro in line 1241.
> > 
> > It is possible to set a large enough NO-OP(NOP) sled, before the
> > actual code, modify the elf_ex->e_entry field so that elf_ex->e_entry+load_bias
> > will be in the range where the NO-OP sled is mapped(because the offset
> > of the PT_LOAD program header of the text segment can be controlled). 
> > This is practically a guess, because load_bias is randomized, the ELF file can
> > be loaded a large amount of times until elf_ex->e_entry + load_bias 
> > is in the range of the NO-OP sled.
> > To conclude, this bug potentially allows the creation of a "fake" entry point
> > field in the ELF file header. 
> > 
> > Suggested git diff:
> > 
> > Add a BAD_ADDR test to elf_ex->e_entry to prevent from using an
> > overflowed elf_entry value.
> > 
> > Signed-off-by: Itay Iellin <ieitayie@gmail.com>
> > ---
> >  fs/binfmt_elf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > index 439ed81e755a..b59dcd5857db 100644
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -1238,7 +1238,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
> >  		kfree(interp_elf_phdata);
> >  	} else {
> >  		elf_entry = e_entry;
> > -		if (BAD_ADDR(elf_entry)) {
> > +		if (BAD_ADDR(elf_entry) || BAD_ADDR(elf_ex->e_entry)) {
> >  			retval = -EINVAL;
> >  			goto out_free_dentry;
> >  		}
> > -- 
> > 2.32.0
> > 
> 
> I am not attaching the replies to my initial report from the discussion with
> members of security@kernel.org, only when or if I will be given permission
> from the repliers to do so.

The replies can be summarized as "are you sure this is an issue, and
if so, that this is really the correct fix at all?"

So I think you need to provide a bit more information here as to why
this really is a problem and how this would not harm valid elf programs.

thanks,

greg k-h
