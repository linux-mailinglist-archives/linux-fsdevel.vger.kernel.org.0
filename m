Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F04B13C243
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 14:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgAONHj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 08:07:39 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46051 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgAONHj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 08:07:39 -0500
Received: by mail-oi1-f195.google.com with SMTP id n16so15258817oie.12;
        Wed, 15 Jan 2020 05:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Uc0xbXgTVUa2g+0VE0qpo9jTGqpit0XhHI4GsKKT/VM=;
        b=HgGdXFIDSNlO1Wse+Ln8TzTGQlaJMQ4UTejLeKnr1VxiJ20xDmvuOWL3Go7oaPa/rc
         kBjg84j4tiOoZrmdF+zV8w4A3qHpFZV9jrwWjIfFjzm/8WkpHlbi3rHGmYrgsBwCIZzo
         S1fsUA1xKeZzAD1NecFw5GDYp/G+3ZVDriiqwSxnsuxmogmQ1+t8kv/KCjaywZkfkKbn
         oCvHJSc/D6rY76WJlE78yWIchkHM7EYK4QMBxA0+5eYsnuk2IAtzB97yTW9fBjwrg8fl
         lY9aB0QeyTcxLXPLEsF1MfAPuLzUJc4wQsTbYAu6aZPcNc7lyl7eCGvc/hEAf2v0xhdF
         3faA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Uc0xbXgTVUa2g+0VE0qpo9jTGqpit0XhHI4GsKKT/VM=;
        b=AB7rUuckC/nKgpTO3reVllw02ZvXcC0fXCx5IBBDtUEnjzOAiMon3a4zgJ1lVewoyg
         aInj2Yly59+Nbp36nzAzCmfdFkWr3oYODg44z/T9E59AHbO/YorIHtSEpYi6zIkeQOy2
         4B0Ld7DQtVKaW5tMbnoXXMlv7QUcqTCqODOmIrG8NHQ3B65bedphizqOTHIfonh/rIT1
         R0tL4gZe01/wHQnEvx3ExlzuEIpBu24hJHEMP+piMDyWMRq9C3VvAWkj5lASHlGclRU+
         1YigiPLJtE/mT7WMwoaQprrsYPcJGNJuwfEvVgRP20XIkUWSTH0rKZplXgKUuSQ+EE7q
         wwkA==
X-Gm-Message-State: APjAAAXl6T+xomXb3jF8DBHVId7ufgDmYREINs4YUAVKLYJuIBxez8kr
        j2rstWD+Zj6hyuLE7XOF9sXRVdOhCWO10onthLo=
X-Google-Smtp-Source: APXvYqy8KPZfk8cDJsJNQSMol4iJR++qWDEKUw7L7ZKirqnVJrVVuMfxN+xO5EiWgDtNwQC/oS05WZZpoq7mkjTzN6g=
X-Received: by 2002:aca:5490:: with SMTP id i138mr21103528oib.69.1579093658646;
 Wed, 15 Jan 2020 05:07:38 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:87:0:0:0:0:0 with HTTP; Wed, 15 Jan 2020 05:07:38 -0800 (PST)
In-Reply-To: <CAK8P3a0Hp4CiMQE8NrZt5vKrSn=-mYEbOXTC+Eqp35=pSocz+A@mail.gmail.com>
References: <CGME20200115082821epcas1p4d76d8668dfac70ae3e3889d4ccb6c3ee@epcas1p4.samsung.com>
 <20200115082447.19520-1-namjae.jeon@samsung.com> <20200115082447.19520-6-namjae.jeon@samsung.com>
 <CAK8P3a0Hp4CiMQE8NrZt5vKrSn=-mYEbOXTC+Eqp35=pSocz+A@mail.gmail.com>
From:   Namjae Jeon <linkinjeon@gmail.com>
Date:   Wed, 15 Jan 2020 22:07:38 +0900
Message-ID: <CAKYAXd9pu=G2DxbcN-aE=ToKAZKgxsDHA2Z3F+gvQnOx5di2fg@mail.gmail.com>
Subject: Re: [PATCH v10 05/14] exfat: add file operations
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Christoph Hellwig <hch@lst.de>, sj1557.seo@samsung.com,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2020-01-15 18:56 GMT+09:00, Arnd Bergmann <arnd@arndb.de>:
> On Wed, Jan 15, 2020 at 9:28 AM Namjae Jeon <namjae.jeon@samsung.com>
> wrote:
>
>> +
>> +               ktime_get_real_ts64(&ts);
>> +               exfat_set_entry_time(sbi, &ts,
>> +                               &ep->dentry.file.modify_time,
>> +                               &ep->dentry.file.modify_date,
>> +                               &ep->dentry.file.modify_tz);
>
> I think this part should use current_time() instead of
> ktime_get_real_ts64()
> so it gets truncated to the correct resolution and range.
>
> Please also check if there are other callers of ktime_get_real_ts64() that
> may need the same change.
Okay, I will change them.
Thanks!
>
>       Arnd
>
