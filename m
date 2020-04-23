Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB701B6121
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 18:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbgDWQmF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 12:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729407AbgDWQmF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 12:42:05 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AB9C09B041
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2020 09:42:05 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f13so7572166wrm.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2020 09:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/1CcdkRUwx63HleiGeZTKTaCxseRNyvJ5A6FdUWWQWQ=;
        b=HXXxp8E0dp0W0Nhm//KnMYEEEBseVYZ9jh0gAum7IO+I0zHLPhgjUcbeINHLfz8hIr
         GHEGkXtXcd3ML4uQZY7Exxl6n8xFsHj4OHB7rwNezzrfGfuO/HSn7yEOIdodLzWLLD0q
         ZL5q7nLCF/Y5YiTa49oorlWGD5m7qx65NMFgYCKhGbL9F3NzvWee8nozVAzHLa8Ke5TY
         RK/2G3z1x/Ao9su5F2xnShZczB0NWOzVwhIlhLhQSqG89qGtIUPreUeufQRZSMQj2VA2
         y2b243dQZPt9J1aXPWrmzlxtCjJaOhTirZLM3FVnxlEK8AopedmJWJRlsmDwk8Qet/jW
         Rmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/1CcdkRUwx63HleiGeZTKTaCxseRNyvJ5A6FdUWWQWQ=;
        b=uFCGN2iLjnkKriJNroXfxS2Z5VHfldeZ6W1OZwYqE7iksFzRWx621SXKPSUNGQQz9E
         p3jLJSjgHxYFKBJLRdwcHfWQa5qdvqkKrMXhKGVBvuTOx2aWD+jVgONq+3AaxNJ/DN2y
         kVUqzte36+ftysyKH1q7mZOIYLcrsUP2n0nIBPr+QGQiwKedXUjLgu60OziijjsOCxOV
         Eb6Rb/oEYzuDHlkSMB8K+gtW/5YmQZjH3Klj/7iGkuL+Yy8BJp/PDGCZS7O0B6ApkMOY
         aukfvYOe3zPo599C7ji/4OSHPLXrey4+BdPjqLsyj+AcoSrg6Jtl3jHYdTPiHDrPquzq
         7G6Q==
X-Gm-Message-State: AGi0PuYLaKPlpFXOZCssX0P1j4zDldlobugBNyo7KHRhDkAzbF5XG4AT
        31buovrlr6T0z5NNL9ITrv1wcBCI/7OjiVWKEgg=
X-Google-Smtp-Source: APiQypJMNBM7UzJ8vmAXewtCeQ5o//8/B0hb2WeBI+DB5Fy/QWyd+5tZpJHwryvUVqEj+G9AI6+AcLUk8NcsnARY6MU=
X-Received: by 2002:a5d:5082:: with SMTP id a2mr5771262wrt.224.1587660123862;
 Thu, 23 Apr 2020 09:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200423153211.17223-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200423153211.17223-1-andriy.shevchenko@linux.intel.com>
From:   Johannes Thumshirn <morbidrsa@gmail.com>
Date:   Thu, 23 Apr 2020 18:41:53 +0200
Message-ID: <CAGH8bx7ACF=JTN4Ry_E41QCRHsbRCoQqQrvGiqCBMQ8tx3u0dA@mail.gmail.com>
Subject: Re: [PATCH v1] zonefs: Replace uuid_copy() with import_uuid()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 23, 2020 at 5:32 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> There is a specific API to treat raw data as UUID, i.e. import_uuid().
> Use it instead of uuid_copy() with explicit casting.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks good,
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
