Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0296779BBB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Aug 2023 02:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbjHLAFP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 20:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233777AbjHLAFO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 20:05:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC78B1BF9;
        Fri, 11 Aug 2023 17:05:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3459F63F0C;
        Sat, 12 Aug 2023 00:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CDAC433C7;
        Sat, 12 Aug 2023 00:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691798697;
        bh=ocsVToj/iVM+XhkH8YNiZ4GKxA2Rc7YUdFp90EQo8T8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pJLVEHvIzbGx8FG3S4BASA9oqvXoB+WSSMea8uqftlDit0geVr92l2KGQ7CsaRTvM
         kyXcfXCL/+Jg1OTOg1G08kbsj+orBeZDuiQTxeRPEPGbFRK4T1vGTyqNrI/SM+sTpd
         3BIfD1J7NYjf5BrrvtX7zXYjLnQLtm1zLaPsIsMkfg0p9/KRE41Dsj/9EkcvAibf2H
         W6qfEsy4tk5MxSJIim9bf9OBJoROguA0/EcCIpOokYlc5DrJcYCZeQbRo6OREsi9cw
         iXtoLsXx0FOh8eWr3uAOcITsFUTuoUMDAeSZ/jEY2wa7Qy4F2Ctr+VkhsdB6LSgh/l
         jFd9HCaO/D81g==
Date:   Fri, 11 Aug 2023 17:04:56 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, corbet@lwn.net,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, cem@kernel.org, sandeen@sandeen.net,
        chandan.babu@oracle.com, leah.rumancik@gmail.com, zlang@kernel.org,
        fstests@vger.kernel.org, willy@infradead.org,
        shirley.ma@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 1/3] docs: add maintainer entry profile for XFS
Message-ID: <20230812000456.GA2375177@frogsfrogsfrogs>
References: <169091989589.112530.11294854598557805230.stgit@frogsfrogsfrogs>
 <169091990172.112530.13872332887678504055.stgit@frogsfrogsfrogs>
 <ZNaMhgqbLJGdateQ@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNaMhgqbLJGdateQ@bombadil.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 11, 2023 at 12:31:18PM -0700, Luis Chamberlain wrote:
> On Tue, Aug 01, 2023 at 12:58:21PM -0700, Darrick J. Wong wrote:
> > +Roles
> > +-----
> > +There are seven key roles in the XFS project.
> > +- **Testing Lead**: This person is responsible for setting the test
> > +  coverage goals of the project, negotiating with developers to decide
> > +  on new tests for new features, and making sure that developers and
> > +  release managers execute on the testing.
> > +
> > +  The testing lead should identify themselves with an ``M:`` entry in
> > +  the XFS section of the fstests MAINTAINERS file.
> 
> I think breaking responsibility down is very sensible, and should hopefully
> allow you to not burn out. Given I realize how difficult it is to do all
> the tasks, and since I'm already doing quite a bit of testing of XFS
> on linux-next I can volunteer to help with this task of testing lead
> if folks also think it may be useful to the community.
> 
> The only thing is I'd like to also ask if Amir would join me on the
> role to avoid conflicts of interest when and if it comes down to testing
> features I'm involved in somehow.

Good question.  Amir?

(/me also notes that he's listed as R: in fstests MAINTAINERS so he can
pinch hit if there are conflicts of interest, at least for xfs/iomap
stuff.)

--D

>   Luis
