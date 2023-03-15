Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55786BBB8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 18:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjCOR6T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 13:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjCOR6L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:58:11 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FEE5293F
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 10:58:08 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32FHvbS8006202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 13:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678903060; bh=09grMownhl4xwuVSr+pgF+GRSd0lyBDxZ4GNkmzKy2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=RPZhtmNcVeepYUr98JKqT8rlvIeu0ui2J2dVmZSBj8WxGHIlq+jyNgFn3+RSXFPL4
         3w7Sibfm65Ovj3WeOm3phrVyAXPaYTXrK8xf8EevulHqQYOGOyGtlhbj5yPhqn+nog
         HIZZXQyDahR0q8yueHachC+zWnCohDtJuQVvpYqbNEwg0IzvdZGf3wnkYG2ypN+A5k
         blnnb9AAzvYWw85wxZtq3ihZSrTktW2bB1T65bhePW8h9yfBet+sJOFo8sHabBLiQy
         WkDdKl197G7yrPAHSVKN6AYM7Yd3dfs98qwmCYfpv9kxe+A9OKVN8EKBB9WAjcJc5N
         leCulAuVZPvVw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CE5BD15C5830; Wed, 15 Mar 2023 13:57:37 -0400 (EDT)
Date:   Wed, 15 Mar 2023 13:57:37 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/31] Convert most of ext4 to folios
Message-ID: <20230315175737.GA3024297@mit.edu>
References: <20230126202415.1682629-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126202415.1682629-1-willy@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I've pushed Jan's data=writeback cleanup patches, which, among other
things completely eliminates ext4_writepage) to the ext4 tree's dev
branch.  So when you rebase these patches for the next version of this
series, please base them on

https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev

Thanks!!

					- Ted
