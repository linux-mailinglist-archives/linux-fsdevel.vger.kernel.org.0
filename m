Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABB0423116
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 21:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbhJET4Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 15:56:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40160 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235134AbhJET4Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 15:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633463673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2mOqbfpTkNmh7xvXw2chGSswBEFKWvgtgchtPO071HU=;
        b=X64d/l+kStlilxEdhYWxConUCQarTuST5EYqFhyxhnvMfqvpENd06Xl05GrLfFFidmaIvM
        f0ejy0aNYCcYSvye/J+wUm/qAOZsTrlj1lU+zfTVbY6BlYJkiqNXBtp1d6Q89UDcCD0y0j
        elBnTid2efjHr8L+QJcumkmLcMfFeqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-tJ8f7WsvNreE73DdUXCudw-1; Tue, 05 Oct 2021 15:54:30 -0400
X-MC-Unique: tJ8f7WsvNreE73DdUXCudw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B707319057A0;
        Tue,  5 Oct 2021 19:54:28 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 06DA710013D7;
        Tue,  5 Oct 2021 19:54:27 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Ramji Jiyani <ramjiyani@google.com>
Cc:     Benjamin LaHaise <bcrl@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, kernel-team@android.com,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RESEND PATCH] aio: Add support for the POLLFREE
References: <20210928194509.4133465-1-ramjiyani@google.com>
        <x49ilybjmdt.fsf@segfault.boston.devel.redhat.com>
        <CAKUd0B_vh5gxsjHVAoC4YTpwUA8vj6qKovza8OM391koM2t+hQ@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Tue, 05 Oct 2021 15:56:20 -0400
In-Reply-To: <CAKUd0B_vh5gxsjHVAoC4YTpwUA8vj6qKovza8OM391koM2t+hQ@mail.gmail.com>
        (Ramji Jiyani's message of "Tue, 5 Oct 2021 12:46:36 -0700")
Message-ID: <x49ee8zjlej.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Ramji,

Ramji Jiyani <ramjiyani@google.com> writes:

> Hi Jeff:
>
> On Tue, Oct 5, 2021 at 12:33 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>>
>> Hi, Ramji,
>>
>> Thanks for the explanation of the use after free.  I went ahead and
>> ran the patch through the libaio test suite and it passed.
>>
>
> Thanks for taking time to test and providing feedback.
>
>> > -#define POLLFREE     (__force __poll_t)0x4000        /* currently only for epoll */
>> > +#define POLLFREE     ((__force __poll_t)0x4000)
>>
>> You added parenthesis, here, and I'm not sure if that's a necessary part
>> of this patch.
>
> I added parenthesis to silence the checkpatch script. Should I just ignore it?
> I'll send v2 with the change, if it is required.

None of the other #defines in that file use parens, so it would, at the
very least, be inconsistent.  I would leave the the parens out.

Cheers,
Jeff

