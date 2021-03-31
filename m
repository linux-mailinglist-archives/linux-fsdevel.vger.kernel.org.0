Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA77C3500ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 15:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbhCaNHP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 09:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbhCaNGm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 09:06:42 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193EAC061574;
        Wed, 31 Mar 2021 06:06:42 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id E04356D17; Wed, 31 Mar 2021 09:06:40 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E04356D17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1617196000;
        bh=3YbQrlnqSUldHf01WcBYujl/uVzJqEIOfb6YZXnxs0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DRpgyrz6goPUcxHxZ5qGs3XboPOX5Iw6q5i/4mndhMWZlcr2kf+xfM+h4Ze6eMbcL
         33SeMGISev13Re6WcAOfs9kblp3uu8bE1mP348WaIjW2RgwdtCQ0WKGCTt8AjhkkEu
         P+MaXEv5qcR71ZGdsId/ITbAsRm7DroiQ+Txd3kw=
Date:   Wed, 31 Mar 2021 09:06:40 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [RFC][PATCH] fanotify: allow setting FAN_CREATE in mount mark
 mask
Message-ID: <20210331130640.GA9686@fieldses.org>
References: <20210328155624.930558-1-amir73il@gmail.com>
 <20210330121204.b7uto3tesqf6m7hb@wittgenstein>
 <CAOQ4uxjVdjLPbkkZd+_1csecDFuHxms3CcSLuAtRbKuozHUqWA@mail.gmail.com>
 <20210330125336.vj2hkgwhyrh5okee@wittgenstein>
 <CAOQ4uxjPhrY55kJLUr-=2+S4HOqF0qKAAX27h2T1H1uOnxM9pQ@mail.gmail.com>
 <20210330141703.lkttbuflr5z5ia7f@wittgenstein>
 <CAOQ4uxirMBzcaLeLoBWCMPPr7367qeKjnW3f88bh1VMr_3jv_A@mail.gmail.com>
 <20210331094604.xxbjl3krhqtwcaup@wittgenstein>
 <CAOQ4uxirud-+ot0kZ=8qaicvjEM5w1scAeoLP_-HzQx+LwihHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxirud-+ot0kZ=8qaicvjEM5w1scAeoLP_-HzQx+LwihHw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 31, 2021 at 02:29:04PM +0300, Amir Goldstein wrote:
> On Wed, Mar 31, 2021 at 12:46 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> > I feel like this is he correct thing to do independently of the fanotify
> > considerations. I think I'll send an RFC for this today or later this
> > week.
> >
> > > 2. Add fsnotify_path_ hooks at caller site - that would be the
> > >     correct thing to do for nfsd IMO
> >
> > I do not have an informed opinion yet on nfsd so I simply need to trust
> > you here. :)
> >
> 
> As long as "exp_export: export of idmapped mounts not yet supported.\n"
> I don't think it matters much.

Last I looked, nfsd support for idmapped mounts looked like it would be
a pretty straightforward job, for what it's worth.

--b.
