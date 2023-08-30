Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4448C78DA98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237768AbjH3Sgl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244962AbjH3ONz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:13:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F50122;
        Wed, 30 Aug 2023 07:13:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17526622C7;
        Wed, 30 Aug 2023 14:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754DDC433C7;
        Wed, 30 Aug 2023 14:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693404832;
        bh=M/S0ZIPByNJ3DtBtCr9KpYCokyyfuLn19Zpy0SNttjA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=eoLFlQzktzeMNc34Py3fqcYdVSmVzP6f2rf2HvCH5Wbiu3L8nqY/NzXGGO4DANtaR
         AFlPuaZWEbpA8S+mk1GQLlNd7Nq1+jMvI6pNbpFXk45naeqA+SqtCb7FkrYV7aRqIX
         jzQsUpVnEAvDYELgRE8F8ZmBz8rfD9RjA53WK7Rp35c6hFkzTpUO/n4L1vtioS/xfI
         Ik0A2o5DdBJGZBz2DGbSCPIF6ZWAz6rqOpjA/ujZNE5hIkG5lIoKOdra7AfZlMMkKx
         vdadYgauKfE/kiKJhTZYmoYo8qqZSV25uMkbFDPdDNBCEj+6P1JQI94QH3Jeoo+fpw
         0RP7HD5s5mU1w==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-573449a364fso3116812eaf.1;
        Wed, 30 Aug 2023 07:13:52 -0700 (PDT)
X-Gm-Message-State: AOJu0YwPzVivzIZNkNywKablx+HNTeGR2TDjNndDqlnm7w2GI29ho6Iu
        8ToF6uayeRRhdhS05cwq3Bbxub7CESDy9+Dn4Ho=
X-Google-Smtp-Source: AGHT+IHkCkn14xv2qXc7hapukvbg48Y7CXu5qoJcS35J6o9zS0kJ4XujL1U+SRRTW0MP6rhxD0GkkwtOzwXGkh3JWVk=
X-Received: by 2002:a4a:7502:0:b0:56e:4ddd:e333 with SMTP id
 j2-20020a4a7502000000b0056e4ddde333mr1883187ooc.9.1693404831643; Wed, 30 Aug
 2023 07:13:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6802:1090:b0:4f6:2c4a:5156 with HTTP; Wed, 30 Aug 2023
 07:13:50 -0700 (PDT)
In-Reply-To: <30bfc906-1d73-01c9-71d0-aa441ac34b96@gmail.com>
References: <30bfc906-1d73-01c9-71d0-aa441ac34b96@gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Wed, 30 Aug 2023 23:13:50 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9q5=NsbeoiC4sL0P-0M_cA-Dpma8Uu0AhWbp7=hbK_QA@mail.gmail.com>
Message-ID: <CAKYAXd9q5=NsbeoiC4sL0P-0M_cA-Dpma8Uu0AhWbp7=hbK_QA@mail.gmail.com>
Subject: Re: [PATCH v2] exfat: add ioctls for accessing attributes
To:     Jan Cincera <hcincera@gmail.com>
Cc:     Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2023-08-27 19:42 GMT+09:00, Jan Cincera <hcincera@gmail.com>:
> Add GET and SET attributes ioctls to enable attribute modification.
> We already do this in FAT and a few userspace utils made for it would
> benefit from this also working on exFAT, namely fatattr.
>
> Signed-off-by: Jan Cincera <hcincera@gmail.com>
Applied, Thanks for your patch!
