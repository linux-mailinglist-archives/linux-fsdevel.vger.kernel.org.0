Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90146EA4A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 09:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjDUH00 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 03:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjDUH0Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 03:26:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9672726B5;
        Fri, 21 Apr 2023 00:26:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33ECD6116A;
        Fri, 21 Apr 2023 07:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94535C433D2;
        Fri, 21 Apr 2023 07:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682061978;
        bh=XIZwQxSmdbbbE9ngb3dPfpaMLJHg9URk2JAPiW2tKJ8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=W6vmAzOCaaQfObpUCun/ED6tnpiS9Dt7t3oBPoBVWgLSkcxztcUdi0xfqef3yUuge
         qnL3rWrA23bdNXj9FI21jJ/NVr9c/rN5FtRsHOleiqdmX8OLddTw90nBp/ys6+bKg/
         n4aN4J40O7CkULWTdCl2dLiy1u/rB0dNQAua5wOik4Pvsm0zEh6BU7sseMI89zWMvr
         YJScra+eMCsFW5kNpqRMnEuo6eCes23XnsSFyyBAH+puhW3zCxyXiG/caQot8ZfRi9
         zKPrQRX8vT0CLSWNpZytN5CA1CITYqPAB5cHGBiXrP7DXsF0bfSIcdnlZs/GOOm0CH
         YHupQKPkXdCKg==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-187b70ab997so9555522fac.0;
        Fri, 21 Apr 2023 00:26:18 -0700 (PDT)
X-Gm-Message-State: AAQBX9eOihiSOvelv21E6r/QEa86EsL1SCNdtl17nmlf1hbB8iadLGtG
        z1O6TJZcVPTAjEEkBchc2d1X/RWYZEd5Imaq0bM=
X-Google-Smtp-Source: AKy350Zn75WAE3Mv5D521UTq38M5bum7e02nfnK8oR1L8O1x7D5DHFpSHOeaqNazXBktHEiqzu8w6NdSOzj+LeFKIfI=
X-Received: by 2002:a05:6820:1acf:b0:542:2321:658b with SMTP id
 bu15-20020a0568201acf00b005422321658bmr1030454oob.2.1682061977767; Fri, 21
 Apr 2023 00:26:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:53dd:0:b0:4d3:d9bf:b562 with HTTP; Fri, 21 Apr 2023
 00:26:17 -0700 (PDT)
In-Reply-To: <20230421023500.GY3390869@ZenIV>
References: <20230315223435.5139-1-linkinjeon@kernel.org> <20230421023500.GY3390869@ZenIV>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 21 Apr 2023 16:26:17 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_Swxd4so5MHt8L5sm8tH=DYC2A6O5609=V3b9Ri6L5Zg@mail.gmail.com>
Message-ID: <CAKYAXd_Swxd4so5MHt8L5sm8tH=DYC2A6O5609=V3b9Ri6L5Zg@mail.gmail.com>
Subject: Re: [PATCH v8 0/3] ksmbd patches included vfs changes
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
        smfrench@gmail.com, senozhatsky@chromium.org, tom@talpey.com,
        brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2023-04-21 11:35 GMT+09:00, Al Viro <viro@zeniv.linux.org.uk>:
> On Thu, Mar 16, 2023 at 07:34:32AM +0900, Namjae Jeon wrote:
>
> OK...  Let's do it that way: I put the first two commits into
> never-rebased branch (work.lock_rename_child), then you pull
> it into your tree (and slap the third commit on top of that)
> while I merge it into #for-next.
Okay. Can I add your acked-by in third patch ?

Thank you!
>
