Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCFB18B7FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 14:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgCSNhN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 09:37:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35993 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbgCSNhM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:37:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id i13so1457907pfe.3;
        Thu, 19 Mar 2020 06:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MbaLg9Gua2M3U1asnVDIvDva7tQ41AoreM1Ms+SYaSk=;
        b=nRi61yuxZ0Xq+2Qr8bOpOgW2XtV6fryd3C0G4dMcc9FFEMKfZGwP+P/GAI17pT9cjn
         1lviN+GIEhx3YiHb3db3mmCnPH5CiTFUs0hR3zK+JcRGkonTqxCrgePfWqm24DVtKC+N
         yKBMMLxYkqoQHnxA9hX3R6YTpQhMUTIU2EkMA3FcYmOAraM8BMrIN/BcbR6OXfguc3Aj
         CRtrYhn61Lez9OI9owj8+MzXzOZ3Al2zvlk2n0sipwdqQik013kKza2ByhsQSUvdQQXB
         4hgKnZjY0Rdf9u5ZaK2sdFyVLPpQIw/+/l3IVizC7fEil118v2V60y5p2BgFFHrSbP+x
         N5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MbaLg9Gua2M3U1asnVDIvDva7tQ41AoreM1Ms+SYaSk=;
        b=nPlBA9Ks+nonFertcmS1fje0jRNVhXJll4uNillC8ZplomqiBOdRQ2D3i9pdqXNJvX
         giZcY0sG8CZw0WP5ovPRVUe23QGUBLFFa72M0gNp6ZtOqJPDR5xaIFfSgpdcCW08lng7
         gBhMse/17eSRC1w119R8R1l1ipbC7iIinMDWiMMQOS+V57dYFDPt8d2r1vvkVU3FKRtM
         iIUr96j/H3pQ1E80HlpVP7xu8gSWMOWuLSIIz1fm8SMKs6iJ2zfr2z+lRfvplpHeHz6w
         jcP0/afv16xqT2RZOYXUOfWwStwCM0wdHB4voo8OyDn0UiOxfQwA4k0tPfjNQ7RZSQhW
         f1ig==
X-Gm-Message-State: ANhLgQ0Vf6G7fby9yk1sxuvPwrI9BBRiSrb6pueU4VL7QxGTBukW3oFt
        oVX6bpK4o3yjbtG9l1K2obG/mXZ4ALYoxfwx9Xk=
X-Google-Smtp-Source: ADFU+vtAoSv40N/3WnXxvMcn62PtlKa6UP0H140pXfQ3uWlj/cLaUak6oaGVR1tGFhEl0JCb/O0lFMkytGGb/lpOUcA=
X-Received: by 2002:a63:798a:: with SMTP id u132mr3546499pgc.203.1584625031303;
 Thu, 19 Mar 2020 06:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200225173541.1549955-1-npiggin@gmail.com> <cover.1584620202.git.msuchanek@suse.de>
 <5cd926191175c4a4a85dc2246adc84bcfac21b1a.1584620202.git.msuchanek@suse.de>
In-Reply-To: <5cd926191175c4a4a85dc2246adc84bcfac21b1a.1584620202.git.msuchanek@suse.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 19 Mar 2020 15:37:03 +0200
Message-ID: <CAHp75VegYhz-hwSUNHbGFB3yiatAWWytwB7Vctf=mCLyCJEy3Q@mail.gmail.com>
Subject: Re: [PATCH v11 8/8] MAINTAINERS: perf: Add pattern that matches ppc
 perf to the perf entry.
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Nayna Jain <nayna@linux.ibm.com>,
        Eric Richter <erichte@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Michael Neuling <mikey@neuling.org>,
        Gustavo Luiz Duarte <gustavold@linux.ibm.com>,
        Allison Randal <allison@lohutok.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 19, 2020 at 2:21 PM Michal Suchanek <msuchanek@suse.de> wrote:
>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> v10: new patch
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bc8dbe4fe4c9..329bf4a31412 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13088,6 +13088,8 @@ F:      arch/*/kernel/*/perf_event*.c
>  F:     arch/*/kernel/*/*/perf_event*.c
>  F:     arch/*/include/asm/perf_event.h
>  F:     arch/*/kernel/perf_callchain.c
> +F:     arch/*/perf/*
> +F:     arch/*/perf/*/*
>  F:     arch/*/events/*
>  F:     arch/*/events/*/*
>  F:     tools/perf/

Had you run parse-maintainers.pl?

-- 
With Best Regards,
Andy Shevchenko
