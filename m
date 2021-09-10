Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3972406B66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 14:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbhIJMae (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 08:30:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:55106 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232997AbhIJMad (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 08:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631276962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RJBKj0rWr14JtdShUr9I4H+LpLxyHnMkq0zZJ6FWWIU=;
        b=hD9aYKGzyMMx6Ia+K3R85zsbx4djbQ1opuOWgPXeOwJYaoBHrTaO5j4Ctxxz6XtVOuxP2x
        aLT+IrY8vnB97t7srGmF8SYY5tFCbEiGKhO65dHRKrBXnr4er8WUvB+02D/DsXNCa5RBiK
        g0EDWxoBNI51d8FpkrKV7q5Sl31baZ4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-iKXubVGJNW-n_GA0n2FzIA-1; Fri, 10 Sep 2021 08:29:21 -0400
X-MC-Unique: iKXubVGJNW-n_GA0n2FzIA-1
Received: by mail-ed1-f69.google.com with SMTP id s15-20020a056402520f00b003cad788f1f6so821893edd.22
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 05:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RJBKj0rWr14JtdShUr9I4H+LpLxyHnMkq0zZJ6FWWIU=;
        b=O+RLeHNloBRP9OgG3QxgkLnMG3/HK9nUfTzatwI9k0F3LL7hppTWS1d9vzAvfWvrBF
         imrtyqFLknDQrdOLMrf5+5/hH10ghMYXC1ZsHCyFfeOAdcvBG1KdGKgURt1NJ5+SlS3s
         tFJvbgnwucbAGnEm2n2Exs5HnBb93czsCJxs0x8yTqes864FhECRW2E63wbJBsy9BEcK
         rJMtAfLf0hbKXBnk1AWpTNWu5ab6nglxol+4S08oAgYLY3aLgCbqcKSL1uUzn/n82Ili
         bDldXKCUfIQcfHTGw+knB23iNoESPpgtrXvX0RKRjClZAWUzunt6LkRP6zsClYew/rvt
         +stg==
X-Gm-Message-State: AOAM5331kOS/cxGdVCxUhjSjDjQrNsEUeC+FuI/tHzUSVzTzVnOTmjEX
        NasRxMZLRRBMMyjsrrJuqgpYGnPOFQV0trFrlF9I9WWKNlnK+Ewt1cfmM+SKM6k6EfluuftPLsP
        A1nPbLZinrLYXFmXJ1Zs4DKzSAA==
X-Received: by 2002:a17:906:2346:: with SMTP id m6mr9204977eja.512.1631276959852;
        Fri, 10 Sep 2021 05:29:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPHRAGQEuGqTnJM27ZaBkgZd+zRxLi4Y3OOWpP/IwERUKJPWfX0VQ0VYYGBh1JVxBNqenvEA==
X-Received: by 2002:a17:906:2346:: with SMTP id m6mr9204960eja.512.1631276959568;
        Fri, 10 Sep 2021 05:29:19 -0700 (PDT)
Received: from omega.lan (ip4-46-39-172-19.cust.nbox.cz. [46.39.172.19])
        by smtp.gmail.com with ESMTPSA id mb14sm2384479ejb.81.2021.09.10.05.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 05:29:19 -0700 (PDT)
Date:   Fri, 10 Sep 2021 14:29:17 +0200
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     =?utf-8?B?0J/QsNCy0LXQuyDQodCw0LzRgdC+0L3QvtCy?= 
        <pvsamsonov76@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: fs/attr.c patch
Message-ID: <20210910122917.qgk35uy6cqs4hhyy@omega.lan>
References: <34c7bdc6-a057-e1a0-0891-757a0a493874@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34c7bdc6-a057-e1a0-0891-757a0a493874@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 10, 2021 at 03:14:44PM +0300, Павел Самсонов wrote:
> 

Please, follow the submitting patches guide included in the documentation:

Documentation/process/submitting-patches.rst

Also, please be sure to describe why {are you changing/do you want to change} the argument from inode to dentry.


-- 
Carlos

