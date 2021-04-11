Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E73635B6B3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Apr 2021 21:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbhDKTMl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Apr 2021 15:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbhDKTMk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Apr 2021 15:12:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6862AC061574;
        Sun, 11 Apr 2021 12:12:22 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a4so10700201wrr.2;
        Sun, 11 Apr 2021 12:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AF6snEhVCyxzYu1PPelm+nQ7qDiQ7Lsm9VpsRbHiZS4=;
        b=sT7ASHAec+MFmaGuM77Zzbqxo1mSWWoGKV4KvXlCUwHaeshS/hA0agmQHu3Y6CUa/P
         AcfgHopR/bvEEHVQdcMwW9s+ngb6VDWi1pHn5BkrMWliU/0uyQuOn/ziNHTo0utMnVzw
         3/DIajFO5f+qo6cU//eShA5Wwx4rxLyqOJtQT+8e02xzdV/4C33ExfdKNou2w7m+aDFU
         s6SrhciRDEwITGiRw7eKZyw5nHUDByRcf4dJvmJZcqlpphx1rfRO0qBvcipD4Ql0ftQN
         8xXqN94IpSeIQ8Gnz/mhW/VyVrtH6ptlBtwAa3r13sZrorDJIcdDUyFxoGKOS7OC7yR7
         OTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AF6snEhVCyxzYu1PPelm+nQ7qDiQ7Lsm9VpsRbHiZS4=;
        b=VBn5dOc/7Fh3ZH3yD+95o/3pJvXz2jciqvo1azD/UfCndcwQFiqK9fxBEou51/8rjv
         xippuLFVcWSJzma/qVi0kZ75i9b8Vw9zVvLOBPN+x5r0lGe3ucifdajJr5dqcyQC/KFz
         Gaz6jqr2NcyokPW76wkk0Dl/h85WfGyY7UYbCpi8POmcUxH1UQsQ2vRLN7xH8zLDxP+G
         UEoKe91qdkhGOVbjQQ5Y28RtCynAFtq89Qd3M1MG2cseJWuRm3DeoTvDX+rlFqiLqmw+
         E9IzOuZ6/ILPBQdWnrLJzUwKiKfqBlyXB+jfBG7txlexbgxGzJgawc2/UslEG11FE6P6
         eJzg==
X-Gm-Message-State: AOAM532Yk+QgHIJg9O7wwqIjoJKAQaOp9mwXzB8qShu0jeQOmpeoQ2Cg
        IA8ymWy2vOctmYXSXkzw7HU=
X-Google-Smtp-Source: ABdhPJw7JPAV20DFaWBopQIxv4XlQwXWq5XZCEgJpQ6TLlsEJN6R10DQT8f4woYazfKa5CisdSD4Ow==
X-Received: by 2002:adf:cc8d:: with SMTP id p13mr28456843wrj.50.1618168340406;
        Sun, 11 Apr 2021 12:12:20 -0700 (PDT)
Received: from [192.168.1.143] ([170.253.51.130])
        by smtp.gmail.com with ESMTPSA id x15sm7069863wmi.41.2021.04.11.12.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Apr 2021 12:12:19 -0700 (PDT)
Subject: Re: [PATCH v5] flock.2: add CIFS details
To:     =?UTF-8?Q?Aur=c3=a9lien_Aptel?= <aaptel@suse.com>,
        mtk.manpages@gmail.com
Cc:     Steve French <smfrench@gmail.com>,
        linux-cifs <linux-cifs@vger.kernel.org>,
        Tom Talpey <tom@talpey.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-man@vger.kernel.org, Pavel Shilovsky <piastryyy@gmail.com>
References: <CAKywueQkELXyRjihtD2G=vswVuaeoeyMjrDfqTQeVF_NoRVm6A@mail.gmail.com>
 <20210322143024.13930-1-aaptel@suse.com> <87wntb3bcj.fsf@suse.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <8d0cc17a-7757-5438-e59f-2b22906d757d@gmail.com>
Date:   Sun, 11 Apr 2021 21:12:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <87wntb3bcj.fsf@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Aurélien,

On 4/9/21 2:13 PM, Aurélien Aptel wrote:
> 
> Friendly ping to the man page maintainers
> 
> Cheers,
> 

Sorry for the delay and thanks for the ping!
Patch applied.

Cheers,

Alex


-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
