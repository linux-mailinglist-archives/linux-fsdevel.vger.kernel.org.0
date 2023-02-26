Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C9A6A35A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 00:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjBZXnN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 18:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBZXnM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 18:43:12 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE581165E
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Feb 2023 15:42:45 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id c11so3976421oiw.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Feb 2023 15:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCdoElXp9rup68yXt/ObtjHwiPOxi8aUBKLbyOugjFo=;
        b=CNWAbMexZoSi0QXJjQar6szYwnvR0avb1pOKR2TYkIBN0lZu543Q69gh4AKR3g3Pnf
         KkqzTvRdMD1ZKJg9umJjFMCK1hSip/JQ/kItL3evrJ2y4gyZ812dF3M1ObbLPsVhBcgX
         Gz1knCQL0GtJtwYeJ6Tew3XRhGyrPcrtbdXce6nAMHF5VfIW/uHRXvbQH7tleovgxNnG
         UxQjSA5Lrmpi0WA7f5WCMSrb2y+UIDGhBO1yltyQSrb/tr9pTYzN05Mpgs947memeq22
         poLyjNK7G6xBC8IR+wOdQ3STAMV0AFx9J/osBnd4HiycG0NjeabUW+i5ttmlDc6d4rEa
         yZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCdoElXp9rup68yXt/ObtjHwiPOxi8aUBKLbyOugjFo=;
        b=Rgup5LmshCRM5YhKf4uSnRL0SQ0nKxj0XiQR/iHqrO5dN1qwcU5iqYWr0LkXU1NEvX
         k1a8skTdwoi8WJw3mo6hbZAfmAy09N+zRf78fGllq4oK3VFFZxx3fzeU8m9L3awFP5Zw
         AcjCext5peauSx9hnh7oeW4cjAQN3+CNqKL8Bz/Q9G8NdKxWqbFRH/mTuVx1CFMqSDP1
         yvGvgDxABv1GufGMT+awGgB6rXBu7mARQLEpkXV+6xqft8P/gOtH1hGqrZS7TGcrZx53
         e8UOvSQnEAQzoFAZmm7wmTyEvUrfCfM3xbBzX3W6lq6+qwm993usoRXy8gXaX1sKAh9Z
         1HEA==
X-Gm-Message-State: AO0yUKX/w3HNA/YQW5RjEVLskQppucR5HQWzo6CFca/5j4thHP0Yw3qV
        JeFdVKz0+hshew8f9DgWhYePlUQXYZwZQC8D
X-Google-Smtp-Source: AK7set/UoWHGbbNOAvwc2JUXwViebzRanExnWeTCttgbAjSYGalFXRV8w4zDqiAteJHtoxVbWT+65w==
X-Received: by 2002:a54:4684:0:b0:378:1ae8:9253 with SMTP id k4-20020a544684000000b003781ae89253mr7341030oic.45.1677454965111;
        Sun, 26 Feb 2023 15:42:45 -0800 (PST)
Received: from smtpclient.apple ([2600:1700:42f0:6600:d1bd:cbb8:c15b:8b88])
        by smtp.gmail.com with ESMTPSA id t26-20020a056808159a00b00383cc29d6b2sm2399999oiw.51.2023.02.26.15.42.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Feb 2023 15:42:44 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [External] [RFC PATCH 75/76] ssdfs: implement file operations
 support
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
In-Reply-To: <Y/l6E6Czw48180ie@casper.infradead.org>
Date:   Sun, 26 Feb 2023 15:42:32 -0800
Cc:     Viacheslav Dubeyko <slava@dubeyko.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Luka Perkov <luka.perkov@sartura.hr>, bruno.banelli@sartura.hr
Content-Transfer-Encoding: quoted-printable
Message-Id: <11EF76ED-A5C2-48A7-84A9-173D861C8404@bytedance.com>
References: <20230225010927.813929-1-slava@dubeyko.com>
 <20230225010927.813929-76-slava@dubeyko.com>
 <Y/l6E6Czw48180ie@casper.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Feb 24, 2023, at 7:01 PM, Matthew Wilcox <willy@infradead.org> =
wrote:
>=20
> On Fri, Feb 24, 2023 at 05:09:26PM -0800, Viacheslav Dubeyko wrote:
>> +int ssdfs_read_folio(struct file *file, struct folio *folio)
>> +{
>> + struct page *page =3D &folio->page;
>=20
> I'm not really excited about merging a new filesystem that's still =
using
> all the pre-folio APIs.  At least you're not using buffer_heads, but
> you are using some APIs which have been entirely removed in 6.3.

I am adopting the folio API step by step. :) I completely agree that =
SSDFS should use
the folio API. As far as I can see, the folio approach is going into the =
kernel gradually.
And I am making changes in SSDFS code with every kernel version. So, the =
goal of review
is to point me out what should be reworked in SSDFS code. And I am happy =
to rework
the SSDFS code.

Thanks,
Slava.

