Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61E96B38ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 09:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjCJIjb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 03:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjCJIi4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:38:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70368108C04;
        Fri, 10 Mar 2023 00:37:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD68EB821EC;
        Fri, 10 Mar 2023 08:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF14C433EF;
        Fri, 10 Mar 2023 08:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678437420;
        bh=I/hw9l4V5COCKaUQ2fR8zwQ/DIav401ZZyXP6L+MUYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qs/niqin5R34Mn5ID5StExSIQCfQnLqk1MQ9/T1cG2zyhLa7kVFtudwIVuXByNlVa
         2Pf22jrOB6kuz5Hw1Z2x553YlueYJikr/emh3FS0iJ6P781rBN635gigTVd+fU9kVb
         VLfnHHDl/FVSdfYrtuV+L9CrXBdgXOKcGYAhKc5DerPW3sEPn2ul66PiJNdPf1Efxy
         HmTzqDZH2UWk+dd076YZZmcgrNpllEZLiCigjr92iSazdZ0/Oxmgvc1loy7euIuPfT
         YubO4myqXTOmWlkMNtAGQNLP+MoPRFF3uuDD5WiLz152AXRSwICYtbfFvxGeFJR7jR
         VQAcDYpqlq1ew==
Date:   Fri, 10 Mar 2023 09:36:55 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] splice: Remove redundant assignment to ret
Message-ID: <20230310083655.w7s4svfoge4cxpnb@wittgenstein>
References: <20230307084918.28632-1-jiapeng.chong@linux.alibaba.com>
 <167835324320.766837.2963092716601467524.b4-ty@kernel.org>
 <20230310034824.GK3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230310034824.GK3390869@ZenIV>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 10, 2023 at 03:48:24AM +0000, Al Viro wrote:
> On Thu, Mar 09, 2023 at 10:15:46AM +0100, Christian Brauner wrote:
> > From: Christian Brauner (Microsoft) <brauner@kernel.org>
> > 
> > 
> > On Tue, 07 Mar 2023 16:49:18 +0800, Jiapeng Chong wrote:
> > > The variable ret belongs to redundant assignment and can be deleted.
> > > 
> > > fs/splice.c:940:2: warning: Value stored to 'ret' is never read.
> > > 
> > > 
> > 
> > Thanks for the cleanup. Seems ok to do so I picked this up,
> > 
> > [1/1] splice: Remove redundant assignment to ret
> >       commit: c3a4aec055ec275c9f860e88d37e97248927d898
> 
> Which branch?

Currently still under

https://git.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git/ fs.misc

I planned on sending a tag to Linus on Saturday.
