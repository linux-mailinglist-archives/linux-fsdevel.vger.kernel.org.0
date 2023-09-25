Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AFA7AD8E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 15:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjIYNTy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 09:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjIYNTu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:19:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1FE11C;
        Mon, 25 Sep 2023 06:19:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65261C433C7;
        Mon, 25 Sep 2023 13:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695647983;
        bh=CCnXyAa5V1opIq3w3OiqafqD5crTWv3Njt2VF/kjYrs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BANIzKPThzrbQAulyOg+n54/jIo/nRI6hwrm+os07aws5fR4ck18YXpvBxAFtbO71
         uVIGjmtxGATa06ZzC+R2ia6zuEKCZ4ERIGj+ansk2PRVRnLK09vVDiMgJPrxhubJr9
         hdtgM/JFzYuUY12VO9cpL/gucdVLHIir8mIgLHGRNmSEISAgzMHTMNSLiovFlK8zJ2
         YOR93/Sw/b2s6xoMvmZBpvXEH7Maxw8r2YPu7Zr3uuN5ycobxkLzJhrF5vf3p9Cv0W
         RJCYzOJ3LGAe7DNXTsjtyHMCXBgCJ/Fl3hh8shiJA/dNicIFyx4MeKPm9v3WjWx9n8
         x+/cS8BDY7lnQ==
Date:   Mon, 25 Sep 2023 15:19:37 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
Message-ID: <20230925-wahlrecht-zuber-3cdc5a83d345@brauner>
References: <20230913152238.905247-1-mszeredi@redhat.com>
 <20230913152238.905247-3-mszeredi@redhat.com>
 <44631c05-6b8a-42dc-b37e-df6776baa5d4@app.fastmail.com>
 <20230925-total-debatten-2a1f839fde5a@brauner>
 <CAJfpegvUCoKebYS=_3eZtCH49nObotuWc=_khFcHshKjRG8h6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegvUCoKebYS=_3eZtCH49nObotuWc=_khFcHshKjRG8h6Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> How about passing u64 *?

struct statmnt_req {
        __u64 mnt_id;
	__u64 mask;
};

?
