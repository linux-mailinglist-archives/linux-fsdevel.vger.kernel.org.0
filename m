Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD0C4162512
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 11:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgBRK5a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 05:57:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:36286 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbgBRK5a (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 05:57:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B1EA8AC67;
        Tue, 18 Feb 2020 10:57:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3E2BE1E0CF7; Tue, 18 Feb 2020 11:57:28 +0100 (CET)
Date:   Tue, 18 Feb 2020 11:57:28 +0100
From:   Jan Kara <jack@suse.cz>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Jan Kara <jack@suse.cz>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>
Subject: Re: [PATCH 43/44] docs: filesystems: convert udf.txt to ReST
Message-ID: <20200218105728.GH16121@quack2.suse.cz>
References: <cover.1581955849.git.mchehab+huawei@kernel.org>
 <2887f8a3a813a31170389eab687e9f199327dc7d.1581955849.git.mchehab+huawei@kernel.org>
 <20200218071205.GC16121@quack2.suse.cz>
 <20200218111138.4e387143@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218111138.4e387143@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 18-02-20 11:13:23, Mauro Carvalho Chehab wrote:
> Em Tue, 18 Feb 2020 08:12:05 +0100
> Jan Kara <jack@suse.cz> escreveu:
> 
> > On Mon 17-02-20 17:12:29, Mauro Carvalho Chehab wrote:
> > > - Add a SPDX header;
> > > - Add a document title;
> > > - Add table markups;
> > > - Add lists markups;
> > > - Add it to filesystems/index.rst.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> > 
> > Thanks! You can add:
> > 
> > Acked-by: Jan Kara <jack@suse.cz>
> 
> Thanks for reviewing it!
>  
> > and I can pickup the patch if you want.
> 
> From my side, it would be ok if you want to pick any patches from this series.
> 
> Still, as they all touch Documentation/filesystems/index.rst, in order
> to avoid (trivial) conflicts, IMO the best would be to have all of them
> applied at the same tree (either a FS tree or the docs tree).

Yeah, I also think it makes more sense to just push them through a single
tree - likely docs tree...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
