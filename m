Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C19672ECF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 22:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239031AbjFMUbB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 16:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239574AbjFMUaz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:30:55 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F671BEF
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 13:30:49 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5428f63c73aso3201342a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 13:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686688249; x=1689280249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KYTi7R1na9a50Ov2kINcNl6p8dn3MSr2AXDHhuOecUI=;
        b=A260gQeEMHclZVygyc4n4vupbAvrqkqlnSosMCjUQD0YbVX7Gy8i2OOdQuIox7hkhN
         8T5kSuAv6qgx7XTcXaTrpa95anM+bQ837h4+gW0RnWvX+GJqL2T65ruQCIM0vWGze9nG
         R/v1av+YEyGKHi6dl13wLfSn/8h1bGTtHfusw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686688249; x=1689280249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYTi7R1na9a50Ov2kINcNl6p8dn3MSr2AXDHhuOecUI=;
        b=jyrdl+WxyDfNHq8572eGJ7dAKbteX+f1/uuhm/Fu/Uq7dLLFb8s1hmhW3w0qzD+HBs
         lK7RynHKx4Ir6QtQV8hZ9gcJV2lJRWR6Puxp8Ov2LrVZ7OIfszMAvwwGHOwnWq2/6KUX
         yBssunZ7HoAAC0o0Dxo3mEc01LwN2kmd2x2xTxf2dbsyfZ7RTZ6nbHQYXsS/wbqp2aTi
         K9Gv7aFxyyvEhPCXDwVZvS2p/yQbtnYlq2MEW9ZJPzh5nwMOhSp2wyaW2jfdc3+JQ7c8
         6hjqzLJTQSi8URlXkWEpZ673wyBUXDbAjXXVyvL4eSanBHRyFFTh+I6duyFz5PHDtgJW
         RZnw==
X-Gm-Message-State: AC+VfDwlyFkb2pZ0UxG8BoQa807P6Oweiy1PEc92K6eMU94yanl5YWH+
        Llibj4MDhchXQl4zBfduf20n4Q==
X-Google-Smtp-Source: ACHHUZ4mHukYbIJE2e2Xi8DHSCtvzzOa3UY5WJSj7UbvOlwZVWsqOvneRIiveTjRTcbTxrWCozkwlw==
X-Received: by 2002:a17:90a:f2c9:b0:25c:1397:3c0b with SMTP id gt9-20020a17090af2c900b0025c13973c0bmr2237895pjb.37.1686688248844;
        Tue, 13 Jun 2023 13:30:48 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 1-20020a17090a034100b0025bf9e02e1bsm3479153pjf.51.2023.06.13.13.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:30:48 -0700 (PDT)
Date:   Tue, 13 Jun 2023 13:30:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tom Rix <trix@redhat.com>
Cc:     mcgrof@kernel.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sysctl: set variable sysctl_mount_point
 storage-class-specifier to static
Message-ID: <202306131330.AAC4C43AC@keescook>
References: <20230611120725.183182-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230611120725.183182-1-trix@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 11, 2023 at 08:07:25AM -0400, Tom Rix wrote:
> smatch reports
> fs/proc/proc_sysctl.c:32:18: warning: symbol
>   'sysctl_mount_point' was not declared. Should it be static?
> 
> This variable is only used in its defining file, so it should be static.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
