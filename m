Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D95557DA4F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 08:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbiGVGco (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 02:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiGVGcn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 02:32:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6A93FA36;
        Thu, 21 Jul 2022 23:32:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C1B7B8275D;
        Fri, 22 Jul 2022 06:32:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409B3C341C7;
        Fri, 22 Jul 2022 06:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658471559;
        bh=ZfV/3G80JQ5U/WzbU/60kdUAzVwIklhZgtdR+E34XQg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=uWh7jzpKluReGVDH2b6+Q+Y/moM3XVZb5l1tj+K0euN1fpAM0B4sQ4zZ4fUOKPDDM
         icHglZKA60bnYHk8L+YtETmFDA0ge69UgyYcLhwv7j/6BiRSR83ozzwE/PBYEzh4/H
         7NCGf36/w2etd7b5kTQM+inQ0eyT/+MSAS2yfhsFNR2XLPQjZ/k3AH3iCy75ZG7YxN
         C+QgABdpTp1J1CkGv23ZyIX82PMLrMoz8PBuH8EtljXnywLOIuja33dbxfkyO8Rv/g
         OKpgkMpMZxpTfJrpzodFyzjdlx1FZwILNS0DFBpwxQXr8OPQr20xSG92cDHndVP2P5
         x5oCujYvvTL+Q==
Received: by mail-wr1-f54.google.com with SMTP id k11so4713290wrx.5;
        Thu, 21 Jul 2022 23:32:39 -0700 (PDT)
X-Gm-Message-State: AJIora+JFr+bNSr0KLKjggUBTdkBMr857ih8ofbpY9EO6tHlKpFh4Gqt
        vKmpYbJoN3MrFsVhT/UV4ZPJOiKz+MBWC06ObSQ=
X-Google-Smtp-Source: AGRyM1u8KuxQy+sDKdavNtnIaObpDNsq25AhSqnPGVwAtCZSZUf9DyhY02FItA3LQ5/yvvy7w/e14DHqZO+azUZlQH0=
X-Received: by 2002:adf:eacb:0:b0:21e:60a2:ae9e with SMTP id
 o11-20020adfeacb000000b0021e60a2ae9emr1353976wrn.295.1658471557383; Thu, 21
 Jul 2022 23:32:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:644a:0:0:0:0:0 with HTTP; Thu, 21 Jul 2022 23:32:36
 -0700 (PDT)
In-Reply-To: <SG2PR04MB3899752B10CFB6CF93A6127C81879@SG2PR04MB3899.apcprd04.prod.outlook.com>
References: <SG2PR04MB3899752B10CFB6CF93A6127C81879@SG2PR04MB3899.apcprd04.prod.outlook.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 22 Jul 2022 15:32:36 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-zdfcJusQX3sBxfANztnmzprp+RtEchCX0_twHq_291w@mail.gmail.com>
Message-ID: <CAKYAXd-zdfcJusQX3sBxfANztnmzprp+RtEchCX0_twHq_291w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] exfat: remove duplicate write directory entries
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
Cc:     "sj1557.seo" <sj1557.seo@samsung.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-07-11 18:29 GMT+09:00, Yuezhang.Mo@sony.com <Yuezhang.Mo@sony.com>:
> Changes for v2:
>   - [1/3]: Fix timing of calling __exfat_write_inode()
>     - __exfat_write_inode() should be called after updating inode.
>     - This call will be removed in [3/3], so the patch series is
>       no code changes between v1 and v2.
>
>
> These patches simplifie the code, and removes unnecessary writes for the
> following operations.
>
> 1. Write data to an empty file
>   * Preparation
>     ```
>     mkdir /mnt/dir;touch /mnt/dir/file;sync
>     ```
>   * Capture the blktrace log of the following command
>     ```
>     dd if=/dev/zero of=/mnt/dir/file bs=${cluster_size} count=1 oflag=append
> conv=notrunc
>     ```
>   * blktrace log
>     * Before
>       ```
>       179,3    0        1     0.000000000    84  C  WS 2623488 + 1 [0]
>  BootArea
>       179,3    2        1    30.259435003   189  C   W 2628864 + 256 [0]
>  /dir/file
>       179,3    0        2    30.264066003    84  C   W 2627584 + 1 [0]
>  BitMap
>       179,3    2        2    30.261749337   189  C   W 2628608 + 1 [0]
>  /dir/
>       179,3    0        3    60.479159007    84  C   W 2628608 + 1 [0]
>  /dir/
>       ```
>     * After
>       ```
>       179,3    0        1     0.000000000    84  C  WS 2623488 + 1 [0]
>  BootArea
>       179,3    3        1    30.185383337    87  C   W 2629888 + 256 [0]
>  /dir/file
>       179,3    0        2    30.246422004    84  C   W 2627584 + 1 [0]
>  BitMap
>       179,3    0        3    60.466497674    84  C   W 2628352 + 1 [0]
>  /dir/
>       ```
>
> 2. Allocate a new cluster for a directory
>   * Preparation
>     ```
>     mkdir /mnt/dir
>     for ((i=1; i<cluster_size/96; i++)); do > /mnt/dir/file$i; done
>     mkdir /mnt/dir/dir1; sync
>     ```
>   * Capture the blktrace log of the following command
>     ```
>     > /mnt/dir/file
>     ```
>   * blktrace log
>     - Before
>       ```
>       179,3    0        1     0.000000000    84  C  WS 2623488 + 1 [0]
>  BootArea
>       179,3    2        1    30.263762003   189  C   W 2629504 + 128 [0]
>  /dir/
>       179,3    2        2    30.275596670   189  C   W 2629376 + 128 [0]
>  /dir/
>       179,3    2        3    30.290174003   189  C   W 2629119 + 1 [0]
>  /dir/
>       179,3    2        4    30.292362670   189  C   W 2628096 + 1 [0]
>  /
>       179,3    2        5    30.294547337   189  C   W 2627584 + 1 [0]
>  BitMap
>       179,3    0        2    30.296661337    84  C   W 2625536 + 1 [0]
>  FatArea
>       179,3    0        3    60.478775007    84  C   W 2628096 + 1 [0]
>  /
>       ```
>     - After
>       ```
>       179,3    0        1     0.000000000    84  C  WS 2623488 + 1 [0]
>  BootArea
>       179,3    3        1    30.288114670    87  C   W 2631552 + 128 [0]
>  /dir/
>       179,3    3        2    30.303518003    87  C   W 2631424 + 128 [0]
>  /dir/
>       179,3    3        3    30.324212337    87  C   W 2631167 + 1 [0]
>  /dir/
>       179,3    3        4    30.326579003    87  C   W 2627584 + 1 [0]
>  BitMap
>       179,3    0        2    30.328892670    84  C   W 2625536 + 1 [0]
>  FatArea
>       179,3    0        3    60.503128674    84  C   W 2628096 + 1 [0]
>  /
>       ```
>
> 3. Truncate and release cluster from the file
>   * Preparation
>     ```
>     mkdir /mnt/dir
>     dd if=/dev/zero of=/mnt/dir/file bs=${cluster_size} count=2
>     sync
>     ```
>   * Capture the blktrace log of the following command
>     ```
>     truncate -s ${cluster_size} /mnt/dir/file
>     ```
>
>   * blktrace log
>     * Before
>       ```
>       179,3    0        1     0.000000000    84  C  WS 2623488 + 1 [0]
>  BootArea
>       179,3    1        1     5.048452334    49  C   W 2629120 + 1 [0]
>  /dir/
>       179,3    0        2     5.062994334    84  C   W 2627584 + 1 [0]
>  BitMap
>       179,3    0        3    10.031253002    84  C   W 2629120 + 1 [0]
>  /dir/
>       ```
>
>      * After
>       ```
>       179,3    0        1     0.000000000  9143  C  WS 2623488 + 1 [0]
>  BootArea
>       179,3    0        2    14.839244001  9143  C   W 2629888 + 1 [0]
>  /dir/
>       179,3    0        3    14.841562335  9143  C   W 2627584 + 1 [0]
>  BitMap
>       ```
>
> Yuezhang Mo (3):
>   exfat: reuse __exfat_write_inode() to update directory entry
>   exfat: remove duplicate write inode for truncating file
>   exfat: remove duplicate write inode for extending dir/file
>
>  fs/exfat/exfat_fs.h |  1 +
>  fs/exfat/file.c     | 82 ++++++++++++++-------------------------------
>  fs/exfat/inode.c    | 41 ++++++-----------------
>  fs/exfat/namei.c    | 20 -----------
>  4 files changed, 37 insertions(+), 107 deletions(-)

Applied, Thanks for your work!
>
> --
> 2.25.1
>
