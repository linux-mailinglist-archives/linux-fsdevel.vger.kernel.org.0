Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15728283D0A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Oct 2020 19:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgJERIv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Oct 2020 13:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgJERIu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Oct 2020 13:08:50 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2449C0613CE;
        Mon,  5 Oct 2020 10:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=d/0Ea5KFPE2u0kNUPyN+aGiClSRuX6fT8lqKJBQXZCE=; b=p2PeAqNW6S6eLKE7i0oTIzsMta
        pq82MLmio58yaa1yByP6DAQC9CXgSieVPm/QsqcpuxwCQfKtRXFSQHfGiTzYvmT3w3L+oFPoOuH+i
        fFCNrBC6+w4cL33oFMXAu4LcKGQBQ4yNmOiaHnWlrJbGlRKbc1SB4C6kWwPRGFLaTKTqwNonhuoBk
        QcbAS1boOeo+jdsBEpJoNR7cW1jUXfJuklD6nq59zfE2Wtj2Nwnt8VXVXusqwKaDOX1bweOne3QIu
        5NzuU6HdtfsaY9YkH6WjKcdR3F4LF27HjgJyHUu+dqgg2uI9Fr96sQHbR68HwOXo4YAiSE7Ygb/wI
        19y7/idw==;
Received: from [2601:1c0:6280:3f0::2c9a]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPTyh-0003kO-Ng; Mon, 05 Oct 2020 17:08:48 +0000
Subject: Re: [RFC PATCH] overlayfs: add OVL_IOC_GETINFOFD ioctl that opens
 ovlinfofd
To:     Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        miklos@szeredi.hu
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        David Howells <dhowells@redhat.com>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201004192401.9738-1-alexander.mikhalitsyn@virtuozzo.com>
 <20201005170227.11340-1-alexander.mikhalitsyn@virtuozzo.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <83d78791-b650-c8d5-e18a-327d065d53d7@infradead.org>
Date:   Mon, 5 Oct 2020 10:08:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201005170227.11340-1-alexander.mikhalitsyn@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/5/20 10:02 AM, Alexander Mikhalitsyn wrote:
>  #define	OVL_IOC_GETLWRFHNDLSNUM			_IO('o', 1)
>  // DISCUSS: what if MAX_HANDLE_SZ will change?
>  #define	OVL_IOC_GETLWRFHNDL			_IOR('o', 2, struct ovl_mnt_opt_fh)
>  #define	OVL_IOC_GETUPPRFHNDL			_IOR('o', 3, struct ovl_mnt_opt_fh)
>  #define	OVL_IOC_GETWRKFHNDL			_IOR('o', 4, struct ovl_mnt_opt_fh)
> +#define	OVL_IOC_GETINFOFD			_IO('o', 5)

Hi,

Quoting (repeating) from
https://lore.kernel.org/lkml/9cd0e9d1-f124-3f2d-86e6-e6e96a1ccb1e@infradead.org/:

This needs to have Documentation/userspace-api/ioctl/ioctl-number.rst
updated also.

...

Are you waiting until it's past RFC stage?

thanks.
-- 
~Randy

