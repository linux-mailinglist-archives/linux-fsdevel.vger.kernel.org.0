Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21ECF6E71A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 05:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbjDSDei (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 23:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjDSDeb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 23:34:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14A27DB2;
        Tue, 18 Apr 2023 20:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=WskFBSgJt3sTthux4SNlXf32MfgYryvADi65cmfAf4c=; b=tP1xBFWasLkA6/+u+LZflTbTtl
        Sytr6YdZM2qIuOqSS4OBjpTAqDw/wCV4Zv9miaJT+qfN/mB2DlE2Me8nlcLD+rv4XnQz1H3p6OF2B
        QLQODY1tEQGEgx7Hvhqj4N6RyMQRPkAlQ6vlgfkr48pQK45LSOHw4uQtg5wrwYf2zuVy3m1wqlGkx
        7kv7N+tE2OgXdNUIuh+E8s6JOr/MuRJOH0gSsJgfkX71wjzULKVt0z08FgWrEUA9Nelv10UCNC/XU
        lUT5TNcZAi9U0hvdGy7uW4/C1f3ZOsCi2QmXn+qoCWjp85Rh1/aPKMF4dGDUKfmSyDIZRUJnnfuYG
        BZrfC4GA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1poyaL-00CvaE-I2; Wed, 19 Apr 2023 03:34:21 +0000
Date:   Wed, 19 Apr 2023 04:34:21 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        xfs <linux-xfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-mm@kvack.org
Subject: Re: [Lsf-pc] [LSF TOPIC] online repair of filesystems: what next?
Message-ID: <ZD9hPSzEign05MTZ@casper.infradead.org>
References: <Y/5ovz6HI2Z47jbk@magnolia>
 <CAOQ4uxj6mNbGQBSpg-KpSiDa2UugBFXki4HhM4DPvXeAQMnRWg@mail.gmail.com>
 <20230418044641.GD360881@frogsfrogsfrogs>
 <CAOQ4uxgUOuR80jsAE2DkZhMPVNT_WwnsSX8-GSkZO4=k3VbCsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgUOuR80jsAE2DkZhMPVNT_WwnsSX8-GSkZO4=k3VbCsw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 18, 2023 at 10:46:32AM +0300, Amir Goldstein wrote:
> On Tue, Apr 18, 2023 at 7:46 AM Darrick J. Wong <djwong@kernel.org> wrote:
> > TBH, most of my fs complaints these days are managerial problems (Are we
> > spending too much time on LTS?  How on earth do we prioritize projects
> > with all these drive by bots??  Why can't we support large engineering
> > efforts better???) than technical.
> 
> I penciled one session for "FS stable backporting (and other LTS woes)".
> I made it a cross FS/IO session so we can have this session in the big room
> and you are welcome to pull this discussion to any direction you want.

Would this make sense to include the MM folks as well?  Certainly MM
has made the same choice as XFS ("No automatic backports, we will cc:
stable on patches that make sense").
