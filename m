Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B299B5F64A4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 12:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiJFK6h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 06:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiJFK6c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 06:58:32 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D9698CAF;
        Thu,  6 Oct 2022 03:58:31 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id qn17so3813584ejb.0;
        Thu, 06 Oct 2022 03:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=dtuWscWrUWja3PJx/MNBAlClayApddB5Fza3lHyp908=;
        b=q2CwkQN0dNAyhiSkuBngj29o+W0Gv8dH9ZUumeFaXEBIkVcPNiivCZF2obZbN1wrm4
         9mLj3p0qd0GWaL30pPva/jYEBbgIhThYEYXwKjsOkyXgKWHq4ztjv5C0wL4DDaHcbDK2
         cSBLT57T61eu/72etWy7BUMGY00vrlzDHJcAtVyfK+3vCdtp70VjKigmHE0/hAQIueEN
         Z/t7RB3y6zNpQjTED3o7WjIH8UVzc3fuhs8gafxVItt+1gBgA2QPvOnr9P+gHkOMLF4T
         EVZAj2ko1K98uSwyeUUXJNaTAndE6sIiOeCVo5RfLaE59oImd9yi4GaPao3EXmbQgzjX
         /D1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dtuWscWrUWja3PJx/MNBAlClayApddB5Fza3lHyp908=;
        b=OJ8p9qgTWqraZpmerFxyHdvmmE6eE9J9JInnEMOSQSQ26HUIiRDQUTz2ubPPryoJJn
         BkbonE8ZWnDbWBiQSid+Gd5eFkgDEGF6qJdQ32Cho10gw5GEs3qavk6MsAlna5TDsq6m
         wMMtQsj3yAjhNN+vZblMpDmAByQFw7mOam7RLUIQPlS6y3dd5vDjbgo9ZQVmbeW7/8pB
         18N38lFsy85m4hMQFU2zeSIikx8yGZ6eiejlVHGfMwv/fyf/8Aeamg7IccvLMoglWB+6
         cqMMNk251eTTW+cUZED7SAyRduvA61WKqIKR096tfl1+I/TPOWrdXuxkRD5m34CAJnlw
         TDkA==
X-Gm-Message-State: ACrzQf0LXuggGX3AQ9/KbsSCxLbg5XpkNWcqblDxsvPsPn97USoolgvp
        3NFeGHOqEY0ArHdmUda/DguqpaK+xJs=
X-Google-Smtp-Source: AMsMyM6MLDP/agBnw6nYvX0NbkG+NdXn/iaPFI8tmlxK6KiJkWX380E9kU434k5TAZwXugX3trWWJQ==
X-Received: by 2002:a17:907:97d5:b0:782:23b0:ecb8 with SMTP id js21-20020a17090797d500b0078223b0ecb8mr3615440ejc.100.1665053910135;
        Thu, 06 Oct 2022 03:58:30 -0700 (PDT)
Received: from masalkhi.. (p5ddb3856.dip0.t-ipconnect.de. [93.219.56.86])
        by smtp.gmail.com with ESMTPSA id n19-20020aa7c693000000b00458a03203b1sm5677703edq.31.2022.10.06.03.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 03:58:29 -0700 (PDT)
From:   Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: RE: A field in files_struct has been used without initialization
Date:   Thu,  6 Oct 2022 12:57:28 +0200
Message-Id: <20221006105728.47115-1-abd.masalkhi@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.dirty
In-Reply-To: <20221006104439.46235-1-abd.masalkhi@gmail.com>
References: <20221006104439.46235-1-abd.masalkhi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> new_fdt->close_on_exec itself has not been initialized, is it intended
> to be like this.

I meant:

newf->close_on_exec_init itself has not been initialized ...

