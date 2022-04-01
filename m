Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E734C4EF89E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 19:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349469AbiDARGp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 13:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237726AbiDARGo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 13:06:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922F31760CE;
        Fri,  1 Apr 2022 10:04:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3EA30B82467;
        Fri,  1 Apr 2022 17:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC926C340EE;
        Fri,  1 Apr 2022 17:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648832691;
        bh=0+VAgkyZsAfzerjupYvsh5/ynaJVm494B61k58jmz/Q=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=H0aa9JLyIMcPmWEX8M3RdAdwtx1EtHvdYP5FwXmlHc7qmBG2732B7zNx5TIc6EtgI
         Pc7qW8MmB4Mhk3gP+8sfBEsxDsQmuoET4D5fCRP+de0t6tpa1gA4DCrT+gcF+0MkQ0
         ReaAEgeidkVipSUD4YdheFgmWHiFzZABamul4zUGgPvwiMa5HOCYIAtMcMN0ZEElcO
         LzXCTY6URMe0DM4SgOTEIgFEhRboseb483v9aP+Q5YWuaDKabwBEIOQtUSJDTBZPNU
         Y0omddpE2mOt9xdAjAQIeSkAI4Yg5//W0vwRbfFmfjAFztzpMexWEFrS/NSynZ3Qbz
         Ni4IzIn8xpySw==
Date:   Fri, 1 Apr 2022 10:04:51 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>,
        fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCHv3 0/4] generic: Add some tests around journal
 replay/recoveryloop
Message-ID: <20220401170451.GB27665@magnolia>
References: <cover.1648730443.git.ritesh.list@gmail.com>
 <20220331145906.2onnohv2bbg3ye6j@zlang-mailbox>
 <20220331161911.7d5dlqfwm2kngnjk@riteshh-domain>
 <20220331165335.mzx3gfc3uqeeg3sz@riteshh-domain>
 <20220401053047.ic4cbsembj6eoibm@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401053047.ic4cbsembj6eoibm@zlang-mailbox>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 01, 2022 at 01:30:47PM +0800, Zorro Lang wrote:
> On Thu, Mar 31, 2022 at 10:23:35PM +0530, Ritesh Harjani wrote:
> > On 22/03/31 09:49PM, Ritesh Harjani wrote:
> > > On 22/03/31 10:59PM, Zorro Lang wrote:
> > > > On Thu, Mar 31, 2022 at 06:24:19PM +0530, Ritesh Harjani wrote:
> > > > > Hello,
> > > >
> > > > Hi,
> > > >
> > > > Your below patches looks like not pure text format, they might contain
> > > > binary character or some special characers, looks like the "^M" [1].
> > 
> > Sorry to bother you. But here is what I tried.
> > 1. Download the mbx file using b4 am. I didn't see any such character ("^M") in
> >    the patches.
> > 2. Saved the patch using mutt. Again didn't see such character while doing
> > 	cat -A /patch/to/patch
> > 3. Downloaded the mail using eml format from webmail. Here I do see this
> >    character appended. But that happens not just for my patch, but for all
> >    other patches too.
> > 
> > So could this be related to the way you are downloading these patches.
> > Please let me know, if I need to resend these patches again? Because, I don't
> > see this behavior at my end. But I would happy to correct it, if that's not the
> > case.
> 
> Hmm... weird, When I tried to open your patch emails, my mutt show me:
> 
>   [-- application/octet-stream is unsupported (use 'v' to view this part) --]
> 
> Then I have to input 'v' to see the patch content. I'm not sure what's wrong,
> this's the 2nd time I hit this "octet-stream is unsupported" issue yesterday.
> 
> Hi Darrick, or any other forks, can you open above 4 patches normally? If that's
> only my personal issue, I'll check my side.

There's no application/octet anywhere in the email that I received.
Has your IT department gone rogue^W^Wincreased value-add again?

--D

> Thanks,
> Zorro
> 
> > 
> > -ritesh
> > 
> 
