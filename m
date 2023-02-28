Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB4E6A601A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 21:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjB1UEX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 15:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjB1UEW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 15:04:22 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB2927D40;
        Tue, 28 Feb 2023 12:04:20 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v16so8216088wrn.0;
        Tue, 28 Feb 2023 12:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O5/+XyO/Q319p7v3c65gs6VB3H+YJNy+TNPluR9wxXk=;
        b=OX7EEe9NyZWs+vIm5HIk6taO/Fm8Gb/KQIEsHl2j6WemdyG4/wpKm7TIdefSK/9PbW
         RphoaEK0QTOiQXJkZxXqnztxTqe4P9QmSdQ0uFsvmdnvu8Q3hr/a7Cj8UT8kAFwmsfZy
         kc83n1ADEZGVWMPJ+Y5MwpULW9Z0GrNRYuYGYJ4MdUPBndTYrkOa8fampj2nnd5UiLpC
         2RXoan9BK2IdiyHr6z7u+bf4JCvqHC5wawBvT+k8QIgGDcYj+SMvBKd3g91vbI1gzPLC
         axmsHyhuJ1/kDlmAW6zAzTjf2vzCUofHbnTscuNd9czzMWgtOUzyxBJ+zA5oXKvKyP7r
         6ElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O5/+XyO/Q319p7v3c65gs6VB3H+YJNy+TNPluR9wxXk=;
        b=7/QT9PEgTxMRzMsbwGPGT0yi3RCD5XTQaQ3S7wxfsT34/DrhZ8wXU+Mnb8LpY/ctr4
         /nAaz5eLUucP2zF96Vgd6m0wHvVTd29rSIGJv6Y/OmP+J3u7r1clcDV6fEcFMm2bAkJg
         z2IF/2GbOD/Z/xiHYtZLFzb77KjhIJZuz5hB6wXKempjpDhaxlNNdeBcx9glHgXuPj7N
         zGc1GaVFOY2VUiSxcYDp9zJc/1OV3/zcFouKJUH5/tB0XzbXM2Eush/1spm+qz8hmpw+
         BdxAUsk7rzePHjow3Yo8CILOvmpaS9dFk+0nyjTh5sEbYbvD7MVsRtTaScmFaCQPGOpe
         xgxg==
X-Gm-Message-State: AO0yUKXY1nS7vQTKG1iFjCktQqM5545YM0xHob2fDQFoCUKKhbb+ugZ6
        plW4j8UnKwSyHRK1Vk8WwQ==
X-Google-Smtp-Source: AK7set+6mgHjCCKE7IUaGtAeDjlKWu5sF4jQNrVA6FLn1DQIg7Wa4B2zha/U9acsGxG8OcgxLVy3CQ==
X-Received: by 2002:a5d:650f:0:b0:2c7:a93:f892 with SMTP id x15-20020a5d650f000000b002c70a93f892mr3582671wru.55.1677614658480;
        Tue, 28 Feb 2023 12:04:18 -0800 (PST)
Received: from p183 ([46.53.249.64])
        by smtp.gmail.com with ESMTPSA id c10-20020a056000104a00b002c5544b3a69sm10359456wrx.89.2023.02.28.12.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 12:04:17 -0800 (PST)
Date:   Tue, 28 Feb 2023 23:04:16 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Serge Hallyn <serge@hallyn.com>,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v3 1/2] capability: add cap_isidentical
Message-ID: <Y/5eQKeEYLvIxKEm@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +static inline bool cap_isidentical(const kernel_cap_t a, const kernel_cap_t b)
> +{
> +	unsigned __capi;
> +	CAP_FOR_EACH_U32(__capi) {
> +		if (a.cap[__capi] != b.cap[__capi])
> +			return false;
> +	}
> +	return true;
> +}

capability_eq() maybe? "isidentical" is kind of ugly.
