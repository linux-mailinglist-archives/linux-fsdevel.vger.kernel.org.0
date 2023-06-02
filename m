Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A4B7202E2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 15:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbjFBNPG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 09:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236165AbjFBNPB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:15:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F6C1BF;
        Fri,  2 Jun 2023 06:14:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23E32638DD;
        Fri,  2 Jun 2023 13:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF38C433D2;
        Fri,  2 Jun 2023 13:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685711654;
        bh=NAnxOpInZJeQDw/H9BNLLs+wEj43N8uqvATbKwqDOuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EjCJGQjZMKQ9y9Hac7ZyzfREvpyNnka7R7nJShPucIdTGxFvJ+oq/rii15vT/x+wZ
         ISLAh4cHXvSV0qHlOtp9y6U7afaoITJi1J5vFqFJkmhnIthjSOEm5Ft0TkoN8T4P/T
         /eAiME5+hQXIk1j/tbljAxaSEph928fvUvOx2Rlz79DEtle84+e1x0wVIPZXgc9jvZ
         rlsq/Vb0DRuLV5Al1kHwthSkgz3kvkIiIZ+4XP1vSSR/EjxVXr0c0VyAYCJk1kA5Ha
         KOW3RJGY3gFn575C/yVBgrL38yX+fFk8RL00Bqy+Lb0PmGCuF3Xfpc9TchNTqYl0EZ
         B6Xr94vON3dyQ==
Date:   Fri, 2 Jun 2023 15:14:09 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, Dave Chinner <david@fromorbit.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: uuid ioctl - was: Re: [PATCH] overlayfs: Trigger file
 re-evaluation by IMA / EVM after writes
Message-ID: <20230602-karaokebar-scheppern-68ebc212479c@brauner>
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
 <078d8c1fd6b6de59cde8aa85f8e59a056cb78614.camel@linux.ibm.com>
 <20230520-angenehm-orangen-80fdce6f9012@brauner>
 <ZGqgDjJqFSlpIkz/@dread.disaster.area>
 <20230522-unsensibel-backblech-7be4e920ba87@brauner>
 <20230602012335.GB16848@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230602012335.GB16848@frogsfrogsfrogs>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 01, 2023 at 06:23:35PM -0700, Darrick J. Wong wrote:
> Someone ought to cc Ted since I asked him about this topic this morning
> and he said he hadn't noticed it going by...

Fwiw, it wasn't intentional. I just dumped people from the old thread
not added new ones iirc.
