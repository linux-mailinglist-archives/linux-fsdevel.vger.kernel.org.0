Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78455620ACC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Nov 2022 09:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbiKHIA1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Nov 2022 03:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbiKHIAZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Nov 2022 03:00:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E53266C;
        Tue,  8 Nov 2022 00:00:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DA16B81996;
        Tue,  8 Nov 2022 08:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1E4C433D6;
        Tue,  8 Nov 2022 08:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667894421;
        bh=43KfpsZS/uf+gytRP/EuW1mZOaK5oeJNqALuCiz++uI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=R0Vih0u6Kg7a4CWwwbGD5mzVRdpDikqWu1UjzkyOnweYTD46WWmdqTq1ECXz8gdSW
         JBwWvNbQy8/HgfSs+t9pCmz2Wn+6BbUwlGvq5y6LByX3ZjqsQfNY+6DCsdhxbpv7j7
         GYp72Tn1zQlz8pq1fYHI+/hwUPneIdFFIuXPAsEfkfCm1xlnR+Xy7JoaYEVvyPcJRa
         n1gupkkpN9ZOikp4YkhCS7PJv3hCfwij9klz/+YhFvonW+boWYQpUCfSx238J8NAor
         WXcNYpZq36GGPcfrCV4yD7tOw+0sjSITmglmbOmcO+8w6g+HdgfkkFRl5VeQRI9NDH
         173EVBY0RYXzQ==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-13b103a3e5dso15450905fac.2;
        Tue, 08 Nov 2022 00:00:21 -0800 (PST)
X-Gm-Message-State: ACrzQf0/237rMZuY82RsXuEeRDxgq53+BMzb8FB4myRwwaB2h7Vwj/9/
        aW9o0l3FMJmIqnpLPL93b4kIY0q4G9RL4IY8vsI=
X-Google-Smtp-Source: AMsMyM4eHL4WUm4xvg06j6OvnD1dwgzzHY31bv/w5rkw6n3wyfptilk/+PZMriZmok29s8NUdJssX8KcMdxDF6lEcmw=
X-Received: by 2002:a05:6870:63aa:b0:13a:fe6c:5ed0 with SMTP id
 t42-20020a05687063aa00b0013afe6c5ed0mr32789985oap.257.1667894420811; Tue, 08
 Nov 2022 00:00:20 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6839:1a4e:0:0:0:0 with HTTP; Tue, 8 Nov 2022 00:00:20
 -0800 (PST)
In-Reply-To: <PUZPR04MB6316C6A981A51EA6C079455D81399@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <PUZPR04MB6316C6A981A51EA6C079455D81399@PUZPR04MB6316.apcprd04.prod.outlook.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 8 Nov 2022 17:00:20 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9q6bSh21=hhfbMOj1BUJAG+eoL9B4gB5jY56KO0Kjb9Q@mail.gmail.com>
Message-ID: <CAKYAXd9q6bSh21=hhfbMOj1BUJAG+eoL9B4gB5jY56KO0Kjb9Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] exfat: simplify empty entry hint
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc:     Sungjong Seo <sj1557.seo@samsung.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-11-02 16:11 GMT+09:00, Yuezhang.Mo@sony.com <Yuezhang.Mo@sony.com>:
> This commit adds exfat_set_empty_hint()/exfat_reset_empty_hint()
> to reduce code complexity and make code more readable.
>
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Andy Wu <Andy.Wu@sony.com>
> Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>
Applied. Thanks for your patch!
