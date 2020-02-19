Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8A4164309
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 12:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgBSLK4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 06:10:56 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43965 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726497AbgBSLK4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 06:10:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582110655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G9ngAADFf0H6tNXWrWk3zBJLW6Dh0uOu2zK7HumFKqU=;
        b=NYdbTTrMYiXJDJMzEB/CHob6QpOyqtvlq1IgrFcD9CBipInSyUIDU+kGpRUy+ubnt4slYx
        ilWuSUR6F8rc9PVd+3ytguZ3E/HVYQfzms8Uu2cFMamaJiCEUuPCh0PqNQkqJIjlhYsXzc
        bU7DGq+oyOTa7BNpd9r0xvbP6r5X+c8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-bvt_ygSfMgOqvjdqwvGhjw-1; Wed, 19 Feb 2020 06:10:52 -0500
X-MC-Unique: bvt_ygSfMgOqvjdqwvGhjw-1
Received: by mail-wm1-f69.google.com with SMTP id y7so40047wmd.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2020 03:10:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G9ngAADFf0H6tNXWrWk3zBJLW6Dh0uOu2zK7HumFKqU=;
        b=A29xkfbVI4XpjT9sgDDqVShPJnGfxBSteRX+NvVUoeC7CpYawonuAEYJ0Z7oLIsf94
         yNYdgX553sOmPvkTRW+64xL6ZsuEWRjHjLcqpqrN0PQlrhDJJandcGvXfyld926Mp2j2
         rTvZUVzK6zZhbI5JoemT3O9mjG00Eics/uMc6Y8ONupNtSwo+zyJmrZD9J2G8uMjwli1
         lQw259g0hemdFSgPSpHqSqnJzwN5INijbQgvhQeramwrj2R7kqA5NScGz81+mfFI1kHs
         BcOu0aEaXuliL7d+mSfT550ONGyND7aOD4pxftErC47RzkolYGaGzr5TxT3Ay0jgSB15
         FxUw==
X-Gm-Message-State: APjAAAWjVlx+3mBqX4bluylbFBoQKG3UfY0ENgIDvgc5BYaKlXxpQSFx
        9hrljwJERml2bvxlyBYkittMNmcdFTqYSFWALrTryH53sDjsKVSCSNoEja+ga+pRIh8VyUlpglX
        mL2KOTkWyJ0gjdKrZJ48J5p5T0w==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr8994474wmi.45.1582110651008;
        Wed, 19 Feb 2020 03:10:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqxgHklSoTJAASymtkOJdhkIhiMJIFRI+F05r4Zs/xNP/kGoNa/TNx+0pu+EJD1dPQoyvi+MUw==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr8994454wmi.45.1582110650820;
        Wed, 19 Feb 2020 03:10:50 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:ec41:5e57:ff4d:8e51? ([2001:b07:6468:f312:ec41:5e57:ff4d:8e51])
        by smtp.gmail.com with ESMTPSA id e1sm2438009wrt.84.2020.02.19.03.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 03:10:50 -0800 (PST)
Subject: Re: [RFC] eventfd: add EFD_AUTORESET flag
To:     Avi Kivity <avi@scylladb.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Davide Libenzi <davidel@xmailserver.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20200129172010.162215-1-stefanha@redhat.com>
 <66566792-58a4-bf65-6723-7d2887c84160@redhat.com>
 <20200212102912.GA464050@stefanha-x1.localdomain>
 <156cb709-282a-ddb6-6f34-82b4bb211f73@redhat.com>
 <cadb4320-4717-1a41-dfb5-bb782fd0a5da@scylladb.com>
 <20200219103704.GA1076032@stefanha-x1.localdomain>
 <c5ea733d-b766-041b-30b9-a9a9b5167462@scylladb.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ced21f4f-9e8a-7c61-8f50-cee33b74a210@redhat.com>
Date:   Wed, 19 Feb 2020 12:10:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <c5ea733d-b766-041b-30b9-a9a9b5167462@scylladb.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 19/02/20 11:43, Avi Kivity wrote:
> 
>> Thanks, that's a nice idea!  I already have experimental io_uring fd
>> monitoring code written for QEMU and will extend it to use
>> IORING_OP_READ.
> 
> Note linux-aio can do IOCB_CMD_POLL, starting with 4.19.

That was on the todo list, but io_uring came first. :)

Paolo

