Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B048F610EEF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 12:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiJ1KqX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 06:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbiJ1KqK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 06:46:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB401A7A14;
        Fri, 28 Oct 2022 03:46:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D97A7B80502;
        Fri, 28 Oct 2022 10:46:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986B1C43141;
        Fri, 28 Oct 2022 10:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666953966;
        bh=0GOxupD0PCRPvzw+G0OTdqPzj8Eevayoc9MyN2qZUBM=;
        h=From:Date:Subject:To:Cc:From;
        b=Wz2Fq2zO2hz9lldRywykHiGC0IxrccfLDzu3bRyDBqbEVqTHwRGpI1p28My8FbFST
         rK48J+U92dqRBwPrOOn6ZUG9P5pXh3CyIm12y7w49vuwyd/4dD2yjoCxzdRHg+ZXIT
         aAUvwtXCsGNymDdJOpFoX2Dw8mzUkwAE/Ku26/zCKDSskB7m90UD23x1NgeriVDWyy
         1XxoW9iUxQuUO86oPvIWOL6rRmLaropeXRIDVn0UzE6KRDV9zqyEyYGGX7j6YBlKHZ
         L0JasKh/hTxce/tg2VGLUKkKdw5BWSad3dpwgtczd725Nq6fh1uMLaJAADCKhkum3j
         BuulASjXilNHg==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-13c2cfd1126so5821509fac.10;
        Fri, 28 Oct 2022 03:46:06 -0700 (PDT)
X-Gm-Message-State: ACrzQf22K5K6SsZvVWc7pKpxWb84zUoGtRrssGTcOU1/yNvpzBf+yH+5
        7vt8UiuT7txkgbEdi1V5Zkr7uzVkl1xPgjQJBfE=
X-Google-Smtp-Source: AMsMyM4qwHAoqaml+e8xqB734gZIPUTgCIbJ/oKHw8fhpT5q+q8EDp+xtpcDHY7UzGtj0gSBQV4sqA/y4YTE5T0uP+Y=
X-Received: by 2002:a05:6870:63aa:b0:13a:fe6c:5ed0 with SMTP id
 t42-20020a05687063aa00b0013afe6c5ed0mr9088447oap.257.1666953965748; Fri, 28
 Oct 2022 03:46:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6838:4424:0:0:0:0 with HTTP; Fri, 28 Oct 2022 03:46:05
 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 28 Oct 2022 19:46:05 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8G1kkpiZbjU2nAWMSffsTXXJeDKorcVrvHptMU3p1jhw@mail.gmail.com>
Message-ID: <CAKYAXd8G1kkpiZbjU2nAWMSffsTXXJeDKorcVrvHptMU3p1jhw@mail.gmail.com>
Subject: [ANNOUNCE] exfatprogs-1.2.0 version released
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     Eric Sandeen <sandeen@sandeen.net>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nicolas Boos <nicolas.boos@wanadoo.fr>, sedat.dilek@gmail.com,
        Hyunchul Lee <hyc.lee@gmail.com>,
        Luca Stefani <luca.stefani.ge1@gmail.com>,
        Matthieu CASTET <castet.matthieu@free.fr>,
        Sven Hoexter <sven@stormbind.net>,
        Ethan Sommer <e5ten.arch@gmail.com>,
        "Yuezhang.Mo" <Yuezhang.Mo@sony.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folk,

We have released exfatprogs 1.2.0 version. In this release, fsck.exfat
is able to fix(repair) corruptions in exFAT(The previous versions only
check consistency).  Also, exfat2img has been added to clone exFAT
storage(only metadata) to the image file.

Any feedback is welcome!:)

CHANGES :
 * fsck.exfat: Keep traveling files even if there is a corrupted
directory entry set.
 * fsck.exfat: Introduce the option "b" to recover a boot sector even
if an exFAT filesystem is not found.
 * fsck.exfat: Introduce the option "s" to create files in
"/LOST+FOUND", which have clusters allocated but was not belonged to
any files.
 * fsck.exfat: Rename '.' and '..' entry name to the one user want.

NEW FEATURES :
 * fsck.exfat: Repair corruptions of an exFAT filesystem. Please refer
to fsck.exfat manpage to see what kind of corruptions can be repaired.
 * exfat2img: Dump metadata of an exFAT filesystem. Please refer to
exfat2img manpage to see how to use it.

BUG FIXES:
 * fsck.exfat: Fix an infinite loop while traveling files.
 * tune.exfat: Fix bitmap entry corruption when adding new volume lablel.

The git tree is at:
      https://github.com/exfatprogs/exfatprogs

The tarballs can be found at:
      https://github.com/exfatprogs/exfatprogs/releases/download/1.2.0/exfatprogs-1.2.0.tar.gz
