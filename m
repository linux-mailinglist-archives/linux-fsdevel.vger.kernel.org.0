Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DCC59FA7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 14:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237498AbiHXMwf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 08:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237421AbiHXMwe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:52:34 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256EF82872;
        Wed, 24 Aug 2022 05:52:33 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id y4so15591518plb.2;
        Wed, 24 Aug 2022 05:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc;
        bh=5O3gTjJ6ltESJu4SxsjjXpoC0Bt2krGALe8GcvjbeUE=;
        b=HLYiwRQ+t6O0/pYgS00yvAvHCwRFVdo5Tb7FTroITP/O4/ldOnAGfw3FMlDbjrBst4
         ARZwHKGk4FGWj8W9KD5X42N944kctOYpeyG/i2skmEaP3OMNLANHai7aZcibKMMBY/gt
         7Afw0AI33uxnlUL4D5M/ZS8WFyZ6E/K4Nz1esGkHMR3CevDpFUuzQCWEVwP8HmttbASA
         +lEoAVulQhISYuNDz+lgYXEZfrjivRMSa4Ka2G6e8jvBkYAztdgPg2yhr9mwlD3hSzXG
         JM+v7o6OM4gHovO3ksIs9Bs7F233hJJ2WKdrzOsBdMS68ZENGLf8W+0gFJ8TXib81Y2i
         zLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc;
        bh=5O3gTjJ6ltESJu4SxsjjXpoC0Bt2krGALe8GcvjbeUE=;
        b=yG4eykDRW4DALc3aRMJsgEyX6cpxadsR21b8sRBdoAO8XZ07zSfQvoqi9k+CAcnTcq
         W9MlBcgHCB8DkQRiaPLoShlyb9XIVh2dDPo5IkMnm1I2fuYSDuESEUVscT3oB5oRpK1s
         Up6kYRp0OOsMjm1mhnTArkmBQmMGlS8Fe+Y6T1wmbYuzsSEs5JyIDuKbXzw5syTTiapf
         Cde2QNdJJysZLChUb6A2pCDuHNhfyt4Tf21Fn/X1PRrYV721skDR6BCPzvdC0xZvyuOx
         dqP12Bi/r7AtXvy7ixKMhfZggo9NZAlmpYgD9eNbnngQzvNlheKkQ12OGpl2tv3/1Pzt
         NYbw==
X-Gm-Message-State: ACgBeo0H1bzypbQ5Sxq7niSSWt+5zLtMZQawDle4gH6FXFuhOiEXioNw
        vJwgPBl6TQ2PZtgt2YMlpMI=
X-Google-Smtp-Source: AA6agR7VeoI9bAfrXnsrK3q8Q/YUUr4MtVN8Zgon5ypoNWyE7BzC1S5bW/PptzbL6/wjOHzZVB1k2Q==
X-Received: by 2002:a17:902:bf06:b0:172:cf73:df43 with SMTP id bi6-20020a170902bf0600b00172cf73df43mr20369846plb.13.1661345552656;
        Wed, 24 Aug 2022 05:52:32 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id z24-20020aa79f98000000b0053627e0e860sm10190811pfr.27.2022.08.24.05.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 05:52:32 -0700 (PDT)
Message-ID: <63061f10.a70a0220.a807f.203f@mx.google.com>
X-Google-Original-Message-ID: <20220824125231.GA223481@cgel.zte@gmail.com>
Date:   Wed, 24 Aug 2022 12:52:31 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     akpm@linux-foundation.org, corbet@lwn.net, adobriyan@gmail.com,
        willy@infradead.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>,
        Xiaokai Ran <ran.xiaokai@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH v3 2/2] ksm: add profit monitoring documentation
References: <20220824070559.219977-1-xu.xin16@zte.com.cn>
 <20220824070821.220092-1-xu.xin16@zte.com.cn>
 <YwXxkqTM66aO1Y9l@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwXxkqTM66aO1Y9l@debian.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 24, 2022 at 04:38:26PM +0700, Bagas Sanjaya wrote:
> On Wed, Aug 24, 2022 at 07:08:21AM +0000, xu xin wrote:
> > +1) How to determine whether KSM save memory or consume memory in system-wide
> > +range? Here is a simple approximate calculation for reference:
> > +
> > +	general_profit =~ pages_sharing * sizeof(page) - (all_rmap_items) *
> > +	         sizeof(rmap_item);
> > +
> > +where all_rmap_items can be easily obtained by summing ``pages_sharing``,
> > +``pages_shared``, ``pages_unshared`` and ``pages_volatile``.
> > +
> > +2) The KSM profit inner a single process can be similarly obtained by the
> > +following approximate calculation:
> > +
> > +	process_profit =~ ksm_merging_sharing * sizeof(page) -
> > +			  ksm_rmp_items * sizeof(rmap_item).
> > +
> 
> The profit formula above can be put into code blocks. Also, align the
> numbered list texts, like:

Thank you for corrections, done.

> 
> ---- >8 ----
> 
> diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
> index 40bc11f6fa15fa..7e3092fe407e37 100644
> --- a/Documentation/admin-guide/mm/ksm.rst
> +++ b/Documentation/admin-guide/mm/ksm.rst
> @@ -194,22 +194,22 @@ be merged, but some may not be abled to be merged after being checked
>  several times, which are unprofitable memory consumed.
>  
>  1) How to determine whether KSM save memory or consume memory in system-wide
> -range? Here is a simple approximate calculation for reference:
> +   range? Here is a simple approximate calculation for reference::
>  
>  	general_profit =~ pages_sharing * sizeof(page) - (all_rmap_items) *
>  	         sizeof(rmap_item);
>  
> -where all_rmap_items can be easily obtained by summing ``pages_sharing``,
> -``pages_shared``, ``pages_unshared`` and ``pages_volatile``.
> +   where all_rmap_items can be easily obtained by summing ``pages_sharing``,
> +   ``pages_shared``, ``pages_unshared`` and ``pages_volatile``.
>  
>  2) The KSM profit inner a single process can be similarly obtained by the
> -following approximate calculation:
> +   following approximate calculation::
>  
>  	process_profit =~ ksm_merging_sharing * sizeof(page) -
>  			  ksm_rmp_items * sizeof(rmap_item).
>  
> -where both ksm_merging_sharing and ksm_rmp_items are shown under the directory
> -``/proc/<pid>/``.
> +   where both ksm_merging_sharing and ksm_rmp_items are shown under the
> +   directory ``/proc/<pid>/``.
>  
>  From the perspective of application, a high ratio of ``ksm_rmp_items`` to
>  ``ksm_merging_sharing`` means a bad madvise-applied policy, so developers or
> 
> Thanks.
> 
> -- 
> An old man doll... just what I always wanted! - Clara


