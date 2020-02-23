Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA87169775
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 13:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgBWMI1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Feb 2020 07:08:27 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46296 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgBWMI1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Feb 2020 07:08:27 -0500
Received: by mail-ed1-f65.google.com with SMTP id p14so8386177edy.13
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2020 04:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+3bMOmlbRvA7zJn3vOuEZuAwgejpM69Egt00+fb0xdY=;
        b=T3WFs3xjFny16290cyxTqgKXSvQHbyNny7C93fqZTGkJV8r9xn+3gn9X+ShN8Mk0WM
         dO0l0LX9EOCikb28IY0VakansjrkDIATf093GmwLD2K0sZ6+9P42gmWllYYzTLFdUz/n
         66IsUkOKkACqO/c2vI1XM9kgtJO9yB1uvVtGzF+m33sJ86nWvS4jN6kzUeBQWjM+i9un
         X9r6zms2nXiyWypxNyjOWJkkynQXOMpYW0OIGduqUoMm2tX5dS+/2kQHKMddBuzoBuAm
         yXltxT8j4g2hIbHmDrlZobCI42zciSKk7RekRZ58PWk1EMYh12RnI3kMC2wdgYb/lrBR
         hK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+3bMOmlbRvA7zJn3vOuEZuAwgejpM69Egt00+fb0xdY=;
        b=cR9xT8cSz/fG2RZZPKRLKsga53Rb0t3VANy6JB9pYsdM94yDxUxOv1xQ1gMQy4Qx0i
         VZjzjb4fSnL2fVVW9w/cLnVfvHUFte8dltLTeLWPbWZ9UcyS3QQ2ju1s2EcgetDntW1T
         WVMLTjsUh9YYMUgE7yGb5a4uPkj1JSaQ89q+WVYtLCTNVI8pO4P00uVI6FLCVXwIR1sF
         SLI731zGfrh5lYvcDiQxCefQMhhMTPaNoMNeGMVY5hNLnS3OCyZkDFr/wM3WOwUiBGa4
         uQ/NmL/DAZaltRsTLPOD7j/CjdO6QiIHA4YpE8U6vsJnIvBR16hoetF8VCAGpXS0OqkZ
         hn8g==
X-Gm-Message-State: APjAAAUpWtImyE9V9Qwlj6K+6t8IPWV/ZhIrtVCWipuI/Y1k3/kXMlvv
        lOJ8HQTNCRiS1K5fokVNIH9ByA==
X-Google-Smtp-Source: APXvYqwujUALm/F4AQXpMk5SgonEseoix+lVm+NIaBFLz/7op3ah/12Xz9FIQF4VlGK8UsYQdVv84Q==
X-Received: by 2002:a17:906:1956:: with SMTP id b22mr42774186eje.276.1582459705235;
        Sun, 23 Feb 2020 04:08:25 -0800 (PST)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id d13sm778142edk.0.2020.02.23.04.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Feb 2020 04:08:24 -0800 (PST)
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
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <eef8e82a-c254-9391-506b-c9de8e52ee0f@arista.com>
Date:   Sun, 23 Feb 2020 12:08:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200115123601.GA3461986@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 1/15/20 12:36 PM, Greg Kroah-Hartman wrote:
> On Tue, Jan 14, 2020 at 05:19:10PM +0000, Dmitry Safonov wrote:
[..]
>> +int sysrq_get_mask(void)
>> +{
>> +	if (sysrq_always_enabled)
>> +		return 1;
>> +	return sysrq_enabled;
>> +}
> 
> Naming is hard.  And this name is really hard to understand.

Agree.


> Traditionally get/put are used for incrementing reference counts.  You
> don't have a sysrq_put_mask() call, right?  :)

Yes, fair point


> I think what you want this function to do is, "is sysrq enabled right
> now" (hint, it's a global function, add kernel-doc to it so we know what
> it does...).  If so, it should maybe be something like:
> 
> 	bool sysrq_is_enabled(void);
> 
> which to me makes more sense.

Err, not exactly: there is a function for that which is sysrq_on().
But for sysctl the value of the mask (or 1 for always_enabled) is
actually needed to show a proper value back to the userspace reader.

Thanks,
          Dmitry
