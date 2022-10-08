Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7E15F8424
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 09:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJHHrh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Oct 2022 03:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJHHrg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Oct 2022 03:47:36 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C87C59246;
        Sat,  8 Oct 2022 00:47:35 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x59so9720733ede.7;
        Sat, 08 Oct 2022 00:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9XWTwkGI5Af//G/T43u5lv++O037WGEnD8xGQHooYMI=;
        b=C7MjMCi5NdoUGDJUaA+9Pdiym75dKCyQt2gZkzSS3JaDfI3mPBk30NOrI0dbVAE5jO
         vYu3f7ZeZkbnyqlwqhbZNbFFOxwsfCpesP8wAcsbAa4r/SJZ5ChFBdo+dknkm5lFjcOs
         bTd6s0TLgTALGEZEVG/WBGNDvZf6IWpgL5m99CBTNOQif/GZEr7ProC4HStleUG+FWZ1
         aTNTfivP3aaMZXwTFEl7logfwS87oTXIpm1YXtdiMuoPdrzMmEazITmUMNdYKMEyQ8Na
         izSvaEYOK2TqUqi/kqV8rDKJuujEKVtLyvn/f85aNDV06Q30n0a79ZIRw56E9GLP+eNd
         LAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9XWTwkGI5Af//G/T43u5lv++O037WGEnD8xGQHooYMI=;
        b=zooE4JwByQ0TLaY2Vd+Ycl+nb9JQoZjmLBx7rAWae8+D8W1QANJ92WT75hO5Sc8Qsg
         GLk6FeGc5FUrjVnoVrjRzii3PdKQi6E+dNQK0QTrbUDK3OiX/r+olWc9Eue23jNhk8DO
         LYFL4n9kl6Kq2KoDezLyZF/ICziEwswOW5DCDCTntzZpHC41AYZ/2fLuLgMVg/6YbfHB
         blXpQLqJ8anxM6breMBN44tQEpBrQLotUgKhxOGQWkQ3FwZK0ekcDeejwctGWGhSBLHT
         x/j9d5PX+j/t9E242c9LkzNg60XEmVj7imbjym3d1oa+GHnFVyrQGG/PKge7K2lCdnIh
         hXQw==
X-Gm-Message-State: ACrzQf0cc9CTc1ChmCmlrCV9jwNtvFUXNIXfJPRJOZ8jbpH7OprkqyDs
        Hm5nFHu3REBjfUWaSq41wzA=
X-Google-Smtp-Source: AMsMyM5ac4ypSl42nPQaGmlLP17RX1zqvqtcF9xletSOBVTCiJDC6vSsCRGFhHGshI2mprUVr3J/9g==
X-Received: by 2002:a05:6402:548a:b0:454:762b:158b with SMTP id fg10-20020a056402548a00b00454762b158bmr7962632edb.362.1665215253304;
        Sat, 08 Oct 2022 00:47:33 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id p21-20020a170906a01500b0072f112a6ad2sm2332115ejy.97.2022.10.08.00.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 00:47:32 -0700 (PDT)
Date:   Sat, 8 Oct 2022 09:47:30 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v8 2/9] selftests/landlock: Locally define __maybe_unused
Message-ID: <Y0ErEnzWUXCk6x92@nuc>
References: <20221001154908.49665-1-gnoack3000@gmail.com>
 <20221001154908.49665-3-gnoack3000@gmail.com>
 <beb43471-48fa-9f8f-767c-a025db3bd660@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <beb43471-48fa-9f8f-767c-a025db3bd660@digikod.net>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 05, 2022 at 08:53:56PM +0200, Mickaël Salaün wrote:
> Thanks for cleaning this. Can you please move this patch just before the
> test patches?

Done.

-- 
