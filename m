Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AC0478F40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Dec 2021 16:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbhLQPLn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Dec 2021 10:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbhLQPLm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:11:42 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D1CC061574;
        Fri, 17 Dec 2021 07:11:42 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id j18so4702096wrd.2;
        Fri, 17 Dec 2021 07:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:content-transfer-encoding;
        bh=L2fRcZSEDgREADQi8ozNIgt6sXZ7Th/KimLRuTl0m+c=;
        b=kKWF5M87hgWdpvOyh7Vbm/8DfOREj3F9Iay4G5zvChQ3Lsq4EqvCFrJn1Ru9gcIK5B
         HsoVUSCCf4Vm3m69qPqGrkvwt+Ml9alEc28UxsglMXj5Mjtl7u7CucFHY3PBKlyqJ7xW
         7gADoIW5RzOuLWjvGyCQ+NiAGPZyHEQHWEgylKKl/IfmzGF+HoqHDPgpBHmPYlXYBP+x
         b4mXHhXGBDdrHRx28eUZEPVU3+AXBP7owbHfyxMhgL1v6y/egkEFQzwlhpt156JG18ss
         ouZu+SN8plP1488Ww6laaiCqYMbFNZL6RhbskmV9R6mVWQSyUUvcDKfme6LQgc4oTJZZ
         tCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:content-transfer-encoding;
        bh=L2fRcZSEDgREADQi8ozNIgt6sXZ7Th/KimLRuTl0m+c=;
        b=7JzqsH3ydjAeIDdAC0FKccA1Y8bVJr8DSnZLCh3rMq8Kgb28DA8HL7K2SjtXugtgq3
         cfQuxonDzHCnNxYvO8gtjjNDSU/ba2Z0Y4HknpmehxLbaY38mmf4yiaEWxXR1O1bLGmq
         CTceXvdmLyqYbDYaliMwtILULz9D8Rh/xLMxRQXwcmoe9J/woHxrkSJjQTVHD8IaisvT
         81UqJKP8VRR8XLAweQxwA0n8Up1YJtnRWJ+g/nrK/7bF1MmOjnabCOA21NnVgZ2+vH1+
         qTvmiqIXkhzUo8bqqFIowO65jOzzXwwDIw9E9IT7YYI5uLC504znq8M3CRNO3PJaHFzr
         R6hQ==
X-Gm-Message-State: AOAM5308E/OWECEcVY2HChmr4s26yl44W33PeN1ZeVVmkhzBwxQ3zGLo
        vziXKOlpVDh/CN3/UMzo0S3XHYt2ZuY=
X-Google-Smtp-Source: ABdhPJwhBk604QQbITBC8c0uxtm8Cuh1fBurkO0gwd6TiYi/rZjCwd4fRbDXiHV9QoytyutIZ/5amA==
X-Received: by 2002:a05:6000:1568:: with SMTP id 8mr2983668wrz.79.1639753900848;
        Fri, 17 Dec 2021 07:11:40 -0800 (PST)
Received: from ?IPV6:2003:ea:8f24:fd00:c4df:e014:c9b1:77c6? (p200300ea8f24fd00c4dfe014c9b177c6.dip0.t-ipconnect.de. [2003:ea:8f24:fd00:c4df:e014:c9b1:77c6])
        by smtp.googlemail.com with ESMTPSA id b197sm7417696wmb.24.2021.12.17.07.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 07:11:40 -0800 (PST)
Message-ID: <b5817114-8122-cf0e-ca8e-b5d1c9f43bc2@gmail.com>
Date:   Fri, 17 Dec 2021 16:11:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Lukas Czerner <lczerner@redhat.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Problem with data=ordered ext4 mount option in linux-next
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On linux-next systemd-remount-fs complains about an invalid mount option
here, resulting in a r/o root fs. After playing with the mount options
it turned out that data=ordered causes the problem. linux-next from Dec
1st was ok, so it seems to be related to the new mount API patches.

At a first glance I saw no obvious problem, the following looks good.
Maybe you have an idea where to look ..

static const struct constant_table ext4_param_data[] = {
	{"journal",	EXT4_MOUNT_JOURNAL_DATA},
	{"ordered",	EXT4_MOUNT_ORDERED_DATA},
	{"writeback",	EXT4_MOUNT_WRITEBACK_DATA},
	{}
};

	fsparam_enum	("data",		Opt_data, ext4_param_data),


