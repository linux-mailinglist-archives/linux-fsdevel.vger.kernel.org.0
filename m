Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC549169779
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 13:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgBWMKc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Feb 2020 07:10:32 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38084 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgBWMKb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Feb 2020 07:10:31 -0500
Received: by mail-ed1-f67.google.com with SMTP id p23so8431172edr.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2020 04:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cV9GjFprkx5E+1tvh5117LArIb5v3xn1vwpYjJGKOo0=;
        b=Ra/xiyzpCPj28cQwon38F3i34wQN0plYY8gbU83lAC61Yq1MnThyuJ09Xvu5hhzAth
         WBZQ1rjdDWipPC33/p8+/xLuTiojUwTPBt3oQUi9mz85susjzHV6RsLIsHjzvva6YY6O
         A5vLC7gLx1vH7ToJF5W+DaQF/eb6CVUkbvKYC11GoNMVDBP3ipv4ntSJcg2kyBh2LcWC
         CW2k2VgZME7ppRCAJUXyZM7NlR3O9RfPKOeuoUv5jXJjS7AUhHE/0rNWAF1JS/4OG2Yz
         vl7Ct90tdD81Eom0MHWXk9rpyGNC7lgWlQif5AhWxA/maOQJpqduz5MCVFEIgt0XGX6K
         yFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cV9GjFprkx5E+1tvh5117LArIb5v3xn1vwpYjJGKOo0=;
        b=gcc4pqMqnLaUHEWsXym6bD0OIbt69+gV2A4LOt8hkpa12qQU4gxE7eRQAsIqcgeSkB
         MYcuZlreDirYluCkHkvsHBoPp/+hQYPuBlOj9Cnmv4BFGbBfh5a+23Rg7H/+BX49kjVa
         JdikxtScd3y5tKz+egHvoIVop457Dy7URI28ZFYSxIwOS3e2UTdidl9ViXMLObOgjKb0
         r/fp+58GB8Udz+Za1rabEwfgEI7+a2VBWV3OU2YpUc1o8vn8vj9/8+dorD276zUb6T1X
         sRPZXFV6ixUb64D+6acHhnelh+sowoDc2LFLVbSHuKgbYRhBkRbWjlLOuZ3fpIhHd89m
         fO+Q==
X-Gm-Message-State: APjAAAX9/cxgmxkNsAZlSOFkqrE9lDf9eu+cDaBy+473C62McJkTqJO2
        Pk/OzwbPAWCun6vjaoPI6/vc4w==
X-Google-Smtp-Source: APXvYqx8lLXn7cqqR0bYOZYmgpBpKi/9KGwso3Nkcit3DnBx58J6Qyr8fWLSZcFMK7GB3e48selV5w==
X-Received: by 2002:a17:906:1117:: with SMTP id h23mr43290636eja.88.1582459828548;
        Sun, 23 Feb 2020 04:10:28 -0800 (PST)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l22sm659207ejq.25.2020.02.23.04.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Feb 2020 04:10:28 -0800 (PST)
Subject: Re: [PATCHv2-next 1/3] sysctl/sysrq: Remove __sysrq_enabled copy
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Jiri Slaby <jslaby@suse.com>, Joe Perches <joe@perches.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org
References: <20200114171912.261787-1-dima@arista.com>
 <20200114171912.261787-2-dima@arista.com>
 <20200115123601.GA3461986@kroah.com>
 <eef8e82a-c254-9391-506b-c9de8e52ee0f@arista.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <9ce5cadb-5e00-a9cf-c22d-92f077141efa@arista.com>
Date:   Sun, 23 Feb 2020 12:10:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <eef8e82a-c254-9391-506b-c9de8e52ee0f@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2/23/20 12:08 PM, Dmitry Safonov wrote:
> 
> On 1/15/20 12:36 PM, Greg Kroah-Hartman wrote:
>> On Tue, Jan 14, 2020 at 05:19:10PM +0000, Dmitry Safonov wrote:
> [..]
>>> +int sysrq_get_mask(void)
>>> +{
>>> +	if (sysrq_always_enabled)
>>> +		return 1;
>>> +	return sysrq_enabled;
>>> +}
>>
>> Naming is hard.  And this name is really hard to understand.
> 
> Agree.
> 
> 
>> Traditionally get/put are used for incrementing reference counts.  You
>> don't have a sysrq_put_mask() call, right?  :)
> 
> Yes, fair point
> 
> 
>> I think what you want this function to do is, "is sysrq enabled right
>> now" (hint, it's a global function, add kernel-doc to it so we know what
>> it does...).  If so, it should maybe be something like:
>>
>> 	bool sysrq_is_enabled(void);
>>
>> which to me makes more sense.
> 
> Err, not exactly: there is a function for that which is sysrq_on().
> But for sysctl the value of the mask (or 1 for always_enabled) is
> actually needed to show a proper value back to the userspace reader.

I'll call it sysrq_mask(), add the kernel-doc to it in v3.

Thanks again,
          Dmitry
