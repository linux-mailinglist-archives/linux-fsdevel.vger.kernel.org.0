Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4B4712D90D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2019 14:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfLaNeF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Dec 2019 08:34:05 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42961 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfLaNeF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Dec 2019 08:34:05 -0500
Received: by mail-ot1-f68.google.com with SMTP id 66so50297798otd.9;
        Tue, 31 Dec 2019 05:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=t6C5LPsLTqJDJKDYSJYKcbXwVWDP7se8O6qosRVSE2M=;
        b=Zhk6YlRoJwnFLwl6JxKwQXSjRZW/U0atOImEN4j2QdR5XGkF9/D1iTLH0TxF5PUbSo
         DWNrIGDz0h05yPGLjov+MCKZFGQJxi9C3KXz2IAsZp+UhG0A6uFiTjGgn9UIKoWnPyMS
         yoTQzpATUoXsZPO+BLMk2OAk1Mi8dhud7KKZCFnFszVoSpWmdCG21DWxMqPqSGNNbfFn
         JMQAxuF06wrvi0ljubIrOALcLbx1Sa7v6F7LDUPrAZZrUElVSN34DMejKBD9wrJ05lvw
         YAQyOcYNJ1v4LvHiHELD4Xp9NTA3CVPu8O3GCVot4cLOV1CkAcfILWG7QM4QXNYPM8c9
         G2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=t6C5LPsLTqJDJKDYSJYKcbXwVWDP7se8O6qosRVSE2M=;
        b=raoAISozzL3HtVPnOC5AmMd1Ux4zmFyQ9SnEh0zfhMwjPFu27/nZ19Tc4kDZ0PfjCK
         JgZCMFNGARvQoFbPJBlV1TaFULhZ4NLk05mfwZ9a0zEeZg3PwDyCAfWTvUyaSpVt9mLH
         bXYM9NNb1B7eEufYt/C2QbEIacbObUuQ3UPGj8wHNNoIVXth8OkIiINbXAjMi+NGn+KE
         ff+L+v6FHj05zssi+C1LO2s5a2kb/x+RBxE8b4h0PFAIK8eeH31Yz++ruFoVrSKtNaxU
         SWLnoJ8qB2fzvXZGgXVuVNz2BpOm8H9WxI0NXsd9NkHBADP0RNKS1ktEP3EAKne5lFZo
         KZMw==
X-Gm-Message-State: APjAAAWpaOsLCUotLSmLzfR7McHNVuuMVqWWvFrBr6pM9TLIOQLNarKk
        BUhdeKLhNOBY/zEFkYyrlP8EjrQDcx0NblimLDc=
X-Google-Smtp-Source: APXvYqw/2awvEbeLXzhYq9dxklhI8V0k8YOnYWx25+izppgBT+RdnG4y9c33rNOCK/gBQ4tA+rmDguEZUZCcxCrqliI=
X-Received: by 2002:a05:6830:10d7:: with SMTP id z23mr79289151oto.114.1577799244703;
 Tue, 31 Dec 2019 05:34:04 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:87:0:0:0:0:0 with HTTP; Tue, 31 Dec 2019 05:34:04 -0800 (PST)
In-Reply-To: <20191229140005.qrffmjnmizstjkh4@pali>
References: <20191220062419.23516-1-namjae.jeon@samsung.com>
 <CGME20191220062737epcas1p3c0f9e408640148c9186b84efc6d6658b@epcas1p3.samsung.com>
 <20191220062419.23516-10-namjae.jeon@samsung.com> <20191229140005.qrffmjnmizstjkh4@pali>
From:   Namjae Jeon <linkinjeon@gmail.com>
Date:   Tue, 31 Dec 2019 22:34:04 +0900
Message-ID: <CAKYAXd_KLP_179DA9GbAdHyF=A9G9dnWm5hR4pGqds9OSgJhcw@mail.gmail.com>
Subject: Re: [PATCH v8 09/13] exfat: add misc operations
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> +#if (BITS_PER_LONG == 64)
>> +	if (second >= UNIX_SECS_2108) {
>> +		tp->second  = 59;
>> +		tp->minute  = 59;
>> +		tp->hour = 23;
>> +		tp->day  = 31;
>> +		tp->month  = 12;
>> +		tp->year = 127;
>> +		return;
>> +	}
>> +#endif
>
> Hello! Why is this code #if-ed? Kernel supports 64 bit long long
> integers also for 32 bit platforms.
>
> Function parameter struct timespec64 *ts is already 64 bit. so above
> #if-code looks really suspicious.
Right, Will remove it.

Thanks for your review!
