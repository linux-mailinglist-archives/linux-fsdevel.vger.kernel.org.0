Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAFD1F35ED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 10:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgFIIKe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 04:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbgFIIKc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 04:10:32 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20695C05BD43;
        Tue,  9 Jun 2020 01:10:32 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ne5so1066779pjb.5;
        Tue, 09 Jun 2020 01:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y5otYZD+qbE4k4VFywBqfszAUWDQ2M196BogGTRyjRs=;
        b=oAprHx3rbEzybw//j1CQWY1tW1GePKMaG+muKOCqutIIkNk7UoGyWZ5XEJpxObQapM
         951BKflym1wah6VPQyAbbuP5GCE9YDCm+I3w5jQrJgWasHXD9HiQcQoK0cXncuN15Bft
         86xp7C+SwU1PSlpaKNPCJx9OhzKAC4Q4i39S9sbjPLlBUGQSY/U6XdxyvDY5NYVA1SkF
         qwKgHajsIbn5CPSvM0XJYk2qn/jd/T6N4rVvV0XH5P23viMNUu0TIP/EWwYezwR7q2wk
         sfeuKtqoctIxF3CDSgqu4WUJbugLF+LwiylTTjJ3hPhdJrT0maUDIsrbQNG43NCcfAZ5
         me6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y5otYZD+qbE4k4VFywBqfszAUWDQ2M196BogGTRyjRs=;
        b=ZH7RsvmA5mgCJutoVUOWKqjd0plpX+U61kZZ0ShlBUOK1Nu5xIJ7Aiym962D++xO9u
         ySrwh686ucuXBLGTXjpwLKQr6idcpJfZ9PAiemuDYIzpl3S2DuU0WAADQhJKcfgyGWHq
         kAa/FyTjZx1PiQBye6IgXI1QdiC7ODYs1Uu59pVTzRRcJN5ArOWQI3tUCxwxSSi+hy12
         3pzQCASFru2dFkK0kwvWosUtiKQl/D0He/ydROqOPogAmsnns17+r40C27G/jxwlwbf2
         F96ZIUyg6jGTqFEVMTeaLTw/LmcIVRadSAlgMLF50TBaAahJCPjCA5tQZdcsq+Dl1YmK
         V0Aw==
X-Gm-Message-State: AOAM531zooXVYOt4HCLIhUCyDBCdODpUyenQa/0uI+NRONnY/KJGXErO
        YY1BzARV0n9axMOTvH9zlgijat7kqKM=
X-Google-Smtp-Source: ABdhPJzcKgf7RHFZVwb18+SIcACHUTUspUI1aNoHBwZFAwcZm/5paUtvilEyshk8DdbvUk4nfcIHRQ==
X-Received: by 2002:a17:902:46b:: with SMTP id 98mr2351516ple.259.1591690231445;
        Tue, 09 Jun 2020 01:10:31 -0700 (PDT)
Received: from ?IPv6:2404:7a87:83e0:f800:99b4:eb52:d0bf:231c? ([2404:7a87:83e0:f800:99b4:eb52:d0bf:231c])
        by smtp.gmail.com with ESMTPSA id a7sm1801022pjd.2.2020.06.09.01.10.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 01:10:30 -0700 (PDT)
Subject: Re: [PATCH 1/3] exfat: add error check when updating dir-entries
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200604084445.19205-1-kohada.t2@gmail.com>
 <CAKYAXd-1D4hr_VqPLV7qHD+Grp9sX=A6ThFg-k69xK66t_c3nA@mail.gmail.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <dc9f9bea-7d72-cfd7-d0f6-23d0d4d95085@gmail.com>
Date:   Tue, 9 Jun 2020 17:10:29 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAKYAXd-1D4hr_VqPLV7qHD+Grp9sX=A6ThFg-k69xK66t_c3nA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> Add error check when synchronously updating dir-entries.
>> Furthermore, add exfat_update_bhs(). It wait for write completion once
>> instead of sector by sector.
> This patch can be split into two also ?

I sent a patch split into 'write multiple sectors at once'
and 'add error check when updating dir-entries'.

The other two patches(2nd & 3rd) are no-changed, so have not been sent.
If you need the other two patches, I will send them.
In that case, please tell me how to write the subject and change-log.

BR
---
Tetsuhiro Kohada <kohada.t2@gmail.com>
