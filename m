Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9EA23C346
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 04:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgHECFs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 22:05:48 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:42351 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725864AbgHECFs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 22:05:48 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id 12C667DB;
        Tue,  4 Aug 2020 22:05:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 04 Aug 2020 22:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        5uI+CgOGOLZ1AJJ9Vgc8GyZNMIa98k0Qry6BMTVflsA=; b=vI/pDyPFyVaLOUjh
        S54XJu0vSR/gRMAAVmEA2fikmWcZDsbt/pXPRLNN93Fao6I3mQ3ckPX2qg24i23N
        SaeO7+J2yngmhXcGmjaVvnoPJRStUAJkhoVLLsIoCt9rrDEdSgTmev4wLuMOgb0Q
        LIUZpFunEGlPHQqibaRgUtwCAqVc0NJ6ti6ewScGb+M5JFGuruWY5Y6L0wOwgWCA
        egjHaClvPozvADFfOlV1FtvmCsT1a0KhQnU858N/fshuEySllxwaU9geWyeW6wVV
        q9NnWkN17tBI2y99CrpZdW96RlE+sYDWZg1I+5ewP+FXS4XrcO1Lpd728EGJg0Ml
        +ri9Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=5uI+CgOGOLZ1AJJ9Vgc8GyZNMIa98k0Qry6BMTVfl
        sA=; b=ouLLvngD+V9Ng+TlLUipCkfGLi80jAa8Nu+wGCQQO4u9yvpvLNPq3ISvK
        tFFr50VYfgQm2NLuytzONd13z5BzVXMJxPEzoxlhzFPWn/8BP96kQAGRBcipgIsK
        3I7+OM4YjJeAWvUNcLxfwOrgUrZ1rnBkaMgMyufzJ6/+IfateWEJsd6XfYn+E8qN
        jShhZJSLQyk2gRmMB2EfY/cxWBjDZmssOeIJdHgNia6Ai/OyhpzRBAvPTKx0ZRps
        yVQwGZuKkrrD+RuMAk3diisXDWAx3EreNJTT/cdWTXQ6XuAIZnXioHGOFglYvyhY
        q5TVcA8kx6PMGov/en+UWA+eXXOTA==
X-ME-Sender: <xms:-BMqX3QXRKfib0iLgy5AvWgqKdJanGbgCedmwsgtNyIF0Z9FtmcpoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrjeejgdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    efteetvdeguddvveefveeftedtffduudehueeihfeuvefgveehffeludeggfejnecukfhp
    peehkedrjedrvdehhedrvddvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:-BMqX4xQ9uM-EnTqh0ADay4ru4lsxj0Yijcz3ALJphF1TuEm7e0nYg>
    <xmx:-BMqX81rrvyIiFGuA_Eu6HT03EBNgUE7c4Y5wFTx_ZE08PkxKIGtOw>
    <xmx:-BMqX3CA_bYMBJyllsSJHRXylqH7VXp5fVnPrlzVvfjsmBRqkY20XA>
    <xmx:-RMqXzOdM8FZdVQR1AL3RkYIgxGxiai1GyEGp1pxoFGxYHj_f1Rb3XSDgy4>
Received: from mickey.themaw.net (58-7-255-220.dyn.iinet.net.au [58.7.255.220])
        by mail.messagingengine.com (Postfix) with ESMTPA id 38C54328005A;
        Tue,  4 Aug 2020 22:05:39 -0400 (EDT)
Message-ID: <94bba6f200bb2bbf83f4945faa2ccb83fd947540.camel@themaw.net>
Subject: Re: [PATCH 10/18] fsinfo: Provide notification overrun handling
 support [ver #21]
From:   Ian Kent <raven@themaw.net>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        mszeredi@redhat.com, christian@brauner.io, jannh@google.com,
        darrick.wong@oracle.com, kzak@redhat.com, jlayton@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Aug 2020 10:05:36 +0800
In-Reply-To: <20200804135641.GE32719@miu.piliscsaba.redhat.com>
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
         <159646187082.1784947.4293611877413578847.stgit@warthog.procyon.org.uk>
         <20200804135641.GE32719@miu.piliscsaba.redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-08-04 at 15:56 +0200, Miklos Szeredi wrote:
> On Mon, Aug 03, 2020 at 02:37:50PM +0100, David Howells wrote:
> > Provide support for the handling of an overrun in a watch
> > queue.  In the
> > event that an overrun occurs, the watcher needs to be able to find
> > out what
> > it was that they missed.  To this end, previous patches added event
> > counters to struct mount.
> 
> So this is optimizing the buffer overrun case?
> 
> Shoun't we just make sure that the likelyhood of overruns is low and
> if it
> happens, just reinitialize everthing from scratch (shouldn't be
> *that*
> expensive).

But maybe not possible if you are using notifications for tracking
state in user space, you need to know when the thing you have needs
to be synced because you missed something and it's during the
notification processing you actually have the object that may need
to be refreshed.

> 
> Trying to find out what was missed seems like just adding complexity
> for no good
> reason.
> 

