Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298165ACE6E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 11:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238016AbiIEI73 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Sep 2022 04:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238000AbiIEI7Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:59:25 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646B7E2
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Sep 2022 01:59:20 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id m1so10427899edb.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Sep 2022 01:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=gDmrQkGmxRWS5lY+fk1/SpL26v085aatdi3bE/bGnp4=;
        b=npDrubyaGyGK3AC8Nlpm0KA9Z4zOqDr3w8JV3B0A/LgDNbaZBaxAS2LE/tkECiqalq
         9xfn2sZopyJ2a8pEvSkmj5L8NUwL50yT9kGJWxcxVAiTtIWDVwKp2/5XKk1tHopCf2xN
         Aibu9Kb4vPK3k2cDDI99XrvSCw4GNL6ZuwW4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=gDmrQkGmxRWS5lY+fk1/SpL26v085aatdi3bE/bGnp4=;
        b=R4P3Jd4uj11ouSrul2pb83iLt6eP4ouX2CEvslqkOxERZs2/aJiIRBs2cdV+2VbgNE
         mAWxqw9sTQI1YwHWa/zSAwl2wDA9+POndALmwZ4xcjKfhc9jgq1atsY6JWthImSk3KAU
         guFh4HXY2yrZ8GDzBjguA8/ff1a8Oquk7DWbAYSIbN9Dzqy4GHY2txRp97d341jpXwAT
         NlctS59QJuSdoeTtHE/D+4hNZJrKVt4/LGVuaTkghcB21fs2LzPn+jfTJbsZu5EPA8no
         RC7cLKacM3VAHqLF5ddT8w1ROh09GfF2VWQKuyZaqTks0S58L5WuGco/XwyIpOy6ltjx
         ztiw==
X-Gm-Message-State: ACgBeo0T5O47vtNL4l8aEIhHAMSPv1bDFufo6XMwMyP50vMNVLeGI4LF
        DQsdWFOJe7+WV3de2YBiX6dbhhrQv5TvwU5U0a1vPQdEY6g=
X-Google-Smtp-Source: AA6agR7svWTVVzA8BYPiTIt1eXKGtRQ79oJVl4zqNxJoUHhoWCefb3roxc5YAeh7oLX5Qi07bBbw/zKz+OFPipFxFvE=
X-Received: by 2002:a05:6402:4517:b0:443:7fe1:2d60 with SMTP id
 ez23-20020a056402451700b004437fe12d60mr42841979edb.133.1662368359015; Mon, 05
 Sep 2022 01:59:19 -0700 (PDT)
MIME-Version: 1.0
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 5 Sep 2022 10:59:07 +0200
Message-ID: <CAJfpegsF1Oohyq942pF0jBxuiybGuP8xab-kvsDU4rbyDRb7xA@mail.gmail.com>
Subject: switching from FAN_MARK_MOUNT to FAN_MARK_FILESYSTEM
To:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Is there anything that needs special attention when switching from
FAN_MARK_MOUNT to FAN_MARK_FILESYSTEM?

Thanks,
Miklos
