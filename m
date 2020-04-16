Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7771AC566
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 16:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442298AbgDPOSE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 10:18:04 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40590 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408787AbgDPOSA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:18:00 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 7E8D32A087F
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
Cc:     linux-fsdevel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH] Implement utf8 unit tests as a kunit test suite.
Organization: Collabora
References: <20200415082826.19325-1-ricardo.canuelo@collabora.com>
        <851rood23s.fsf@collabora.com>
        <20200416075146.zo5bcx5eoatbdgvx@rcn-XPS-13-9360>
Date:   Thu, 16 Apr 2020 10:17:54 -0400
In-Reply-To: <20200416075146.zo5bcx5eoatbdgvx@rcn-XPS-13-9360> ("Ricardo
        =?utf-8?Q?Ca=C3=B1uelo=22's?= message of "Thu, 16 Apr 2020 09:51:46 +0200")
Message-ID: <855zdz5xbh.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ricardo Cañuelo <ricardo.canuelo@collabora.com> writes:


> I don't think it's a good idea to have the version specifier hardcoded twice in
> the same file, one in string form (for utf8_load) and another one in integer
> form (for the rest of the functions that take the version as a parameter). I
> think it'd be a better option to use a macro to stringify the version number
> from the integer constants and avoid the snprintf entirely:
>
> #define str(s) #s
> #define VERSION_STR(maj, min, rev) str(maj) "." str(min) "." str(rev)
>
> ...
>
> table = utf8_load(VERSION_STR(latest_maj, latest_min, latest_rev));
>
>
> This way we can define the version constant only once, in integer form, and
> then the string form will be a constant generated at compile time. Are you ok
> with this?

fine with me.

Thanks,

-- 
Gabriel Krisman Bertazi
