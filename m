Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DEF6E7615
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 11:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjDSJSm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 05:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjDSJSl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 05:18:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845CF192;
        Wed, 19 Apr 2023 02:18:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FE8062FEF;
        Wed, 19 Apr 2023 09:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35951C433D2;
        Wed, 19 Apr 2023 09:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681895919;
        bh=0JRt4+UCgQcLvAFBrSwg6hQTLtsT165JbVFD1DMmGTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tVOLZBc1HT1azFTxkgfFVCmTv1LQMfjkxqyxBGDzIykRsicPawbusI/vAp3eWJxqt
         3AwTamYzxG1+OPwzkew8fuH76K5GD9ryrDFvTEItYRVBwGZWQDz4tv3T6POc3Dyjyq
         lBs8L9Q2tuX04xZoegOUSc2wUqhGS36tX8L00EuaWZ+/sFxrFi0awcQrT6zU+rU6uK
         jm64XXsNBy14w4qc8+CH2zy0abMm2ZNSQING7bQIEHXBUM5liaAnbGXyRhCD6+/AX2
         tiKQO1Gm3DD9dzR0hUJs7oqt6Iy+MUiVXrHQ+EuqCBH93DwuuWK3VehwjMhUlVcqUK
         Y9Db41aKxT1Ag==
Date:   Wed, 19 Apr 2023 11:18:28 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mezgani Ali <ali.mezgani@gmail.com>
Cc:     Ameer Hamza <ahamza@ixsystems.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com,
        arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        f.fainelli@gmail.com, slark_xiao@163.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, awalker@ixsystems.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Add new open(2) flag - O_EMPTY_PATH
Message-ID: <20230419-dachorganisation-infozentrum-40a4234d6a4c@brauner>
References: <20221228160249.428399-1-ahamza@ixsystems.com>
 <20230106130651.vxz7pjtu5gvchdgt@wittgenstein>
 <ZD9AsWMnNKJ4dpjm@hamza-pc>
 <7454A798-1277-411A-853C-635B33439029@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7454A798-1277-411A-853C-635B33439029@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 19, 2023 at 01:46:16AM +0000, Mezgani Ali wrote:
> Look Hamza,
> 
> The style you’re writing with project a reader of drafts and IETF documents.
> Interesting what you are doing here in Kernel files.
> 
> But let me tell you I suspect you are a hyper virtualized Moroccan ( Hypocrite ).
> 
> One solution you have HR and leave.

Nonsensical off-topic mails like this with thinly veiled personal
attacks are not acceptable. So stop it.
