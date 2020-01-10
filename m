Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E50DB1378A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 22:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgAJVpp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jan 2020 16:45:45 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39663 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgAJVpo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jan 2020 16:45:44 -0500
Received: by mail-pf1-f196.google.com with SMTP id q10so1745185pfs.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2020 13:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=85uBcaKJVYynn+Km3yZLrt2LABn/ujp4kH1tchf72pQ=;
        b=fFk+ijjG8oQy7LHiL7KQwoSUrPKToO3xGIfQktv7xCVRr50sD04tjZDR0VioAFl3mE
         2UvNLpoV/EQaPK8Tw6WgOPZbbBU89HmvvmmGkCkPrVtcWA6ZlnkyO2lFqW4vmq367U49
         kNrRqygH2oUX4SawAcIrPySvrA8TbliPHsgcBw0tIChmiwryBDq+EqZ4BKclRoSrYDhH
         +oYPiQ/6TmgYTA3EAP1+7vjvNkhj2k5F5bx4v9ReVyJJnqNmdIZzoZAl4QL4YT/mdanr
         Jwc9lwCptjwNXWa9qP3KOLSOq8QrEUAWTrbcKwny7SgVvmx2avkQt5RnZBI3zg/i+dEf
         UPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=85uBcaKJVYynn+Km3yZLrt2LABn/ujp4kH1tchf72pQ=;
        b=VQDE8xBYPFxIsMpzcm48wy42BsvM/ygUy7yNFN2WfbQTy4AhU5u5ecArywNVOdHHRG
         GW1gH/XWetA5KfwytRoBwhBO2LdPELpTwy76w01AgFeFG8i1nQJYCGxq9T/TqO11Nlmr
         fhPm1ieYc4q96GhojtusU+G0kH3PzEz3iK4WlAMfjZa9KwdBRZVbQlL/nvHhoqIHxMPy
         9xL7umGzFjhh1gRBV+hXEkSUN4rsU07R+5+IHyGb8lpYKgI22uLnCZV2ia3fbBcH9JkC
         HAmw9L2njFuYGusfHq439Uarou2+m+uTNXaOYQjvJ3U7FE/lVkxZsP4KZdrduWJac8Hf
         CnzA==
X-Gm-Message-State: APjAAAUviqVr2N3cEWW9umo3HaetiLzGHtQSGfMFZ3LKPT2wZZHKBaqO
        d5yi/XT4T6QE41d3EEHsA6/TOA==
X-Google-Smtp-Source: APXvYqxgE7a0uaAsLuTGuMgpdPUQxw+3dqFpxr4k4kTVVg1Wowt51riMR900Qq1pwViSA3TKwYiZVg==
X-Received: by 2002:a63:1101:: with SMTP id g1mr6656701pgl.435.1578692743701;
        Fri, 10 Jan 2020 13:45:43 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j2sm4059514pfi.22.2020.01.10.13.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 13:45:42 -0800 (PST)
Subject: Re: [PATCH-next 2/3] sysctl/sysrq: Remove __sysrq_enabled copy
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org
References: <20200109215444.95995-1-dima@arista.com>
 <20200109215444.95995-3-dima@arista.com> <20200110164035.GA1822445@kroah.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <04436968-5e89-0286-81e5-61acbe583f73@arista.com>
Date:   Fri, 10 Jan 2020 21:45:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200110164035.GA1822445@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Greg,

On 1/10/20 4:40 PM, Greg Kroah-Hartman wrote:
> On Thu, Jan 09, 2020 at 09:54:43PM +0000, Dmitry Safonov wrote:
[..]
>> @@ -2844,6 +2827,26 @@ static int proc_dostring_coredump(struct ctl_table *table, int write,
>>  }
>>  #endif
>>  
>> +#ifdef CONFIG_MAGIC_SYSRQ
>> +static int sysrq_sysctl_handler(struct ctl_table *table, int write,
>> +				void __user *buffer, size_t *lenp, loff_t *ppos)
>> +{
>> +	int tmp, ret;
>> +
>> +	tmp = sysrq_get_mask();
>> +
>> +	ret = __do_proc_dointvec(&tmp, table, write, buffer,
>> +			       lenp, ppos, NULL, NULL);
>> +	if (ret || !write)
>> +		return ret;
>> +
>> +	if (write)
>> +		sysrq_toggle_support(tmp);
>> +
>> +	return 0;
>> +}
>> +#endif
> 
> Why did you move this function down here?  Can't it stay where it is and
> you can just fix the logic there?  Now you have two different #ifdef
> blocks intead of just one :(

Yeah, well __do_proc_dointvec() made me do it.

sysrq_sysctl_handler() declaration should be before ctl_table array of
sysctls, so I couldn't remove the forward-declaration.

So, I could forward-declare __do_proc_dointvec() instead, but looking at
the neighborhood, I decided to follow the file-style (there is a couple
of forward-declarations before the sysctl array, some under ifdefs).

I admit that the result is imperfect and can put __do_proc_dointvec()
definition before instead, no hard feelings.

Thanks,
          Dmitry
