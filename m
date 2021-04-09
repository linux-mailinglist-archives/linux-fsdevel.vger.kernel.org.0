Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D643597CD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 10:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhDII1L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 04:27:11 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:50731 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229696AbhDII1K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 04:27:10 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 842375807DD;
        Fri,  9 Apr 2021 04:26:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 09 Apr 2021 04:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        xQ22oJrPdr8ttUQBECVG7+D3ZB+31AsiXie3G3/5ob0=; b=rCQ4Ier+zYzGVyZ/
        RCCR+QoLIzj06GknW577bs88qwdOaDwnaAXuWpOCtfBwdhFmxg2xkpQn6ky+K5Xz
        rGwmNFnnerWKgjH0qVvT8kOPHXsUu6Lf4Eg2Hwe1L7mHtx3+ACM1yw+nOwcI1DqJ
        sODQWbLJcyh2KdVudnghfjh5VZ+Ll+7xMMSjJuZ5lPF3HgHMo/n4sfLjuZvTgmrm
        muN1WpkC7OQeOy2jh7DKRKLMOUPQfiM3IMlGQrKV8pu3hBobTMDBqiw/09X1IRQb
        qljY83o5nWEBW5geA0u+RGsvJOmmwgYRtbqm2ghi4XNjYglt67RHsEBxZKvrzQX0
        oWbyaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=xQ22oJrPdr8ttUQBECVG7+D3ZB+31AsiXie3G3/5o
        b0=; b=WKQWjw930eIBJ6uU891H9a+WVjwI4Jqipx0QF4ebecw+5zY8IiyikxHXj
        JU3BbKIZBzdR9DfvNSjftBuW73Wlfy26yQqQ21W2A/rne/l3KvTiBHHE4bN6meMU
        GyOaM/hLPa9CL/EO0Z4gPY32lKyqaYJBZ6WcQw2TInGKUTvK1NEK0dTqIfpEEsXj
        zjpsd1sj5ktVOBu2D+c4gCBQn5/h1lk/EOKbLqfUboXEYLCCEFmwybItpwv+oeXh
        gT7L9uaKgS5JcCqe9GvCKICdJewo2GA7jU6gs0BvfamO1Yx4bsCY/yT+uQ8nbtLU
        g8Ut+LbDJbQCulnqzfE8xzfRG0Nfg==
X-ME-Sender: <xms:zw9wYJBWWvf789qfpk8-LXIBI8L9QdSJH9OBeAtMz929rpgdCaLsLg>
    <xme:zw9wYHhX8m_jXUbstdag5Wd-OQAjHr7s_GVmOHuzC-xXuF96WYasV2_b2MmrGDJm1
    xc0jRegRPyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekuddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    effeettedvgeduvdevfeevfeettdffudduheeuiefhueevgfevheffledugefgjeenucfk
    phepuddvuddrgeegrddugeegrdduiedunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:zw9wYElmxQ6T0_gJfU4S3hdBsIVsQ3ZrGm-1J6SHgf0aRXlFVUcSiw>
    <xmx:zw9wYDyPIYJXnTMGMSAYsqO-TVtZK2-ayPHIuGzqjG8FYWl3XeFvWw>
    <xmx:zw9wYOSojd4TC15ViXf4CBYpECVJbc7bfsLUwqZMuBEgaSho21IUsg>
    <xmx:0Q9wYLSvAOaUXFGXcTqOn7-qLtrT3JIYx2jLcAA6EH3EPyUk3ppa2w>
Received: from mickey.themaw.net (unknown [121.44.144.161])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5B9BB240065;
        Fri,  9 Apr 2021 04:26:51 -0400 (EDT)
Message-ID: <e0331787cd2ab96deed8be162223585416ed4a97.camel@themaw.net>
Subject: Re: [PATCH v3 2/4] kernfs: use VFS negative dentry caching
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Brice Goglin <brice.goglin@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Fri, 09 Apr 2021 16:26:47 +0800
In-Reply-To: <YG+vSdNLmgwXrwgJ@zeniv-ca.linux.org.uk>
References: <161793058309.10062.17056551235139961080.stgit@mickey.themaw.net>
         <161793090597.10062.4954029445418116308.stgit@mickey.themaw.net>
         <YG+vSdNLmgwXrwgJ@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-04-09 at 01:35 +0000, Al Viro wrote:
> On Fri, Apr 09, 2021 at 09:15:06AM +0800, Ian Kent wrote:
> > +		parent = kernfs_dentry_node(dentry->d_parent);
> > +		if (parent) {
> > +			const void *ns = NULL;
> > +
> > +			if (kernfs_ns_enabled(parent))
> > +				ns = kernfs_info(dentry->d_parent-
> > >d_sb)->ns;
> 
> 	For any dentry d, we have d->d_parent->d_sb == d->d_sb.  All
> the time.
> If you ever run into the case where that would not be true, you've
> found
> a critical bug.

Right, yes.

> 
> > +			kn = kernfs_find_ns(parent, dentry-
> > >d_name.name, ns);
> > +			if (kn)
> > +				goto out_bad;
> > +		}
> 
> Umm...  What's to prevent a race with successful rename(2)?  IOW,
> what's
> there to stabilize ->d_parent and ->d_name while we are in that
> function?

Indeed, glad you looked at this.

Now I'm wondering how kerfs_iop_rename() protects itself from
concurrent kernfs_rename_ns() ... 

