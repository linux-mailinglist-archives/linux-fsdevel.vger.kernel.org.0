Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94A2817B5F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2019 16:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfEHONu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 May 2019 10:13:50 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:54639 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfEHONu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 May 2019 10:13:50 -0400
Received: by mail-it1-f195.google.com with SMTP id a190so4267798ite.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 May 2019 07:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=OELUENc3UGFI4n64xtHyWctIjuS1FHXlpju+VHmaEhI=;
        b=dLgN7MwfahWL5KRvq3nO48znS+N9vOxoLsZ0QKbz7QjqM81X6SYBt5biQTM7+yWxNn
         61hwvNv4/Xge+ia6X9lVvgneqZgtbYVP2Fu0ONbXMlWp9sMU4vqYUuo0GiNV349YSA2l
         oiebe0j3GbK+pGQNSEjH0cQ+geiyC6ydVuvIjaZmTua1E2WPE0b1k3VP/lh0cTvcJ/Px
         Nl4FNQ8D6JkogwX2s8u8O8CZ/VlqG8itnONJUFQoHub+tPKUqEXZ4rUDrkPQFZWPNfOm
         VzpBSYTemWyOdzXnZ++1T28ctbhpB5M7GrKg9Ws5SQgbnaArchI0+JMZvrI4IdIDQaPD
         4ycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=OELUENc3UGFI4n64xtHyWctIjuS1FHXlpju+VHmaEhI=;
        b=nCdgCV+4m0OeGxj5U+ZcjCgzQlg21zO7xheAXKZZTUkBuj6nZXOIrz0uXhTSo8yheR
         6FCrgCgRcbKbg/Ih+2qyIElTHp4D8uKgtRfjWug7Me6FiTAS5+Kn9C9h/7QQwmooLeIF
         aANONgbBUxMmWVkFSpxplteZRl4ROUAxfYZsSp+2O3KTr2S+AiLlCtymw6SxWLmIzgD2
         57z9krqU+KKhS0l+OODtsZnZ5bThf8UtzNyOyrFo/qxsTBEdsct+oOXnA2PaP5jAE6im
         /qWbOqIWEosA/mzDOsfX4L2kXSmeICUNep3laaG0NHpqOw3dqvyvCWuW4otk67MKI80X
         hU5Q==
X-Gm-Message-State: APjAAAWXuQ2/cMW7HpXrHvEQ3SDnal1VSxwipJwDUkL9nf39lTXI0k09
        bylL6vld9s0c+uXvx+lMwHNklw==
X-Google-Smtp-Source: APXvYqxyZFk7D1oD/2eJU/YNb79OWIUwIVwdt2F+Z5X5GYcbtQ+wiIBOk/azDs0gGrN5+XNcPkN1bg==
X-Received: by 2002:a05:6638:94:: with SMTP id v20mr27688629jao.2.1557324829960;
        Wed, 08 May 2019 07:13:49 -0700 (PDT)
Received: from [26.66.241.113] ([172.56.12.182])
        by smtp.gmail.com with ESMTPSA id r6sm2554802iog.38.2019.05.08.07.13.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 07:13:48 -0700 (PDT)
Date:   Wed, 08 May 2019 16:13:32 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <4158.1557324343@warthog.procyon.org.uk>
References: <20190508132218.3617-1-christian@brauner.io> <4158.1557324343@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] fs: make all new mount api fds cloexec by default
To:     David Howells <dhowells@redhat.com>
CC:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Christian Brauner <christian@brauner.io>
Message-ID: <937AFC55-9B52-44C1-893E-CE396F1BD5B7@brauner.io>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On May 8, 2019 4:05:43 PM GMT+02:00, David Howells <dhowells@redhat=2Ecom> =
wrote:
>Christian Brauner <christian@brauner=2Eio> wrote:
>
>> -	fd =3D get_unused_fd_flags(flags & O_CLOEXEC);
>> +	fd =3D get_unused_fd_flags(flags | O_CLOEXEC);
>
>That'll break if there are any flags other than O_CLOEXEC=2E
>
>> -	ret =3D get_unused_fd_flags((flags & FSMOUNT_CLOEXEC) ? O_CLOEXEC :
>0);
>> +	ret =3D get_unused_fd_flags(flags | O_CLOEXEC);
>
>That'll break because flags is not compatible with what
>get_unused_fd_flags()
>is expecting=2E

Technically only when new flags are added=2E
Right now it works correctly=2E
I'll send a v1 soon=2E

Thanks for catching that, David=2E
Christian

