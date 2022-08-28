Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7715A3F24
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Aug 2022 20:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiH1SmH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Aug 2022 14:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiH1SmG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Aug 2022 14:42:06 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BD12FFD9;
        Sun, 28 Aug 2022 11:42:04 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b16so82883wru.7;
        Sun, 28 Aug 2022 11:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=nPeeJvcw+APlSjQr5GEfxQ1+CYvYngFa4Na2HCLoP7o=;
        b=LaihOXgWdYphgrrA7SBrJOIUhVNl3ESUJDgGPDUfngsClPDVDKzpQko70TrGPfL36F
         zf38+tv/rqp5oeiVGa+TEEOMuDZU3KT7cuYIqHTfS1JUaQLVNP3523BkxepBk1HXD7e5
         okwFBPi/pXCcWC9gHBDusyz+XPhlomVuRkWO/z2vtgE8CEjtKqJUgYU/KKjBdUWeH2BR
         p0O2HeopYHek3fkBGn5PIwqw/v4N7317ur4o9iZHqkzAmB6BMT9eNAu4RP008KP89wD4
         4kCva8i3Ly5Eg2WPnf7wy8foFcNWHhAy/GQhyvl6jB3SZtuOK9GHFG+FAHYokFhOwXIv
         GdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=nPeeJvcw+APlSjQr5GEfxQ1+CYvYngFa4Na2HCLoP7o=;
        b=Kr/FiSuQEO5q3s+2wnXheSfpAOrfl5VrkqzR0htmnRYj8KKJHdxligMPun7A1Oy9iX
         siicyoWKUYflZyB2ko06Sns9Hcpyz2rSV3dshnQ4vWFqVBq0IQzjx17V4IBjHyOPlp+H
         DbBxKTmo1shnLD1oUVPCaIwG1QSl/m02nwd3Rb6FW0NkfphJPHCW8eL5ywI8stQO0zIH
         bUEyIxGc5eBfqhG6YOHkp8AwIKY534mBBzLzms8Kn6Ku1RRGC51NiCFTfhmjW1oh6Dn0
         NDpBZSX2jeCINJwh5oFjb8L+CjWl/21Os2onwYwtpELu44QqSSOlX+EnToQwWJKZsrFD
         Ba3Q==
X-Gm-Message-State: ACgBeo2va4ZVVkGVtbh39tRaLJLglG1KFLa5Uh5HEf7ro1YQ/65rJEZK
        n98qx0aMHBOSiD3SMPq2kw==
X-Google-Smtp-Source: AA6agR7ZQHVA++7orMaEY7LtCr7ATgaqFa5xAhWfk3pG0NldsIBx9iCH7CjFTtfP+gAErEpY1M+qFA==
X-Received: by 2002:a05:6000:61e:b0:225:5119:94b with SMTP id bn30-20020a056000061e00b002255119094bmr4726937wrb.650.1661712122970;
        Sun, 28 Aug 2022 11:42:02 -0700 (PDT)
Received: from localhost.localdomain ([46.53.248.164])
        by smtp.gmail.com with ESMTPSA id w18-20020adfde92000000b00226d238be98sm4233967wrl.82.2022.08.28.11.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 11:42:02 -0700 (PDT)
Date:   Sun, 28 Aug 2022 21:42:00 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     xu xin <cgel.zte@gmail.com>
Cc:     akpm@linux-foundation.org, corbet@lwn.net, bagasdotme@gmail.com,
        willy@infradead.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, xu xin <xu.xin16@zte.com.cn>,
        Xiaokai Ran <ran.xiaokai@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH v4 1/2] ksm: count allocated ksm rmap_items for each
 process
Message-ID: <Ywu2+OiL9oqohr1v@localhost.localdomain>
References: <20220824124512.223103-1-xu.xin16@zte.com.cn>
 <20220824124615.223158-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220824124615.223158-1-xu.xin16@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 24, 2022 at 12:46:15PM +0000, xu xin wrote:
> +static int proc_pid_ksm_rmp_items(struct seq_file *m, struct pid_namespace *ns,
> +				struct pid *pid, struct task_struct *task)
> +{
> +	struct mm_struct *mm;
> +
> +	mm = get_task_mm(task);
> +	if (mm) {
> +		seq_printf(m, "%lu\n", mm->ksm_rmp_items);
> +		mmput(mm);
> +	}
> +
> +	return 0;
> +}
>  #endif /* CONFIG_KSM */
>  
>  #ifdef CONFIG_STACKLEAK_METRICS
> @@ -3334,6 +3347,7 @@ static const struct pid_entry tgid_base_stuff[] = {
>  #endif
>  #ifdef CONFIG_KSM
>  	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
> +	ONE("ksm_rmp_items",  S_IRUSR, proc_pid_ksm_rmp_items),
>  #endif

Another tiny /proc/$pid/ file?

Guys, this problem with "find /proc" instantiating megabytes is not
getting better only worse.

How did KSM didn't get its own /proc/*/ksm file with many values?

Maybe add /proc/*/ksm and start filling it with stuff leaving
/proc/*/ksm_merging_pages alone?
