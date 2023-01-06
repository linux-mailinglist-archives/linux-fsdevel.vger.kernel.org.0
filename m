Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1BD660726
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jan 2023 20:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbjAFTaq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 14:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235500AbjAFTao (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 14:30:44 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B264F131
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jan 2023 11:30:43 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-15085b8a2f7so2623419fac.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Jan 2023 11:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1fk0YAUxvXFlZJTRQ3F9ZCTQJkHjJR6GtTYlUtgX2A=;
        b=FmxcEfBuZ3BcJBPLeEXAm+2UU+kfkrYXMXnG8AYdHxqzNoxM5he0X9/wo2YMM5PGJR
         6fHt3+425DZfxKvYI0IAAZPdnhDoCxSEXe6947GLQUfJnRv4PfS8POfHiGAu41H9mM6i
         Nr2GZZwvpjqezvuVgiGhCnINqy9v0DVPL/AzvB7/aBZBPr6NVCsRBXiTk0wMuJ8EWSZ6
         zV9Mtp+4av+TS2n57dEk0OqDfXSEEJ0sMu5X5JBZMY6zyVzCIedtxuqElF/pLUqI5IAR
         9QLXlirxTuPm+E0mff4kOVHRKCqg01JldZN7T273QMFbjpeSFUa7+QXLHSR9m0iQo3Jn
         S+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n1fk0YAUxvXFlZJTRQ3F9ZCTQJkHjJR6GtTYlUtgX2A=;
        b=6nMlD+X/rd3s9rGJeblOEwINmWq6/NK62HdFHPKgDCatiPzbX1AryDFLAzFBfyXf9v
         F55efeixRsKLFk++Wd/BzloxYJOOJNP9pfSkEyS47Ekh0CduX7VunbI8qmH6dCTvT1JK
         3KApjVp1LD52KRGG8NVKq9IodQtL01fY2UoB6gEDo9eJnq8SUFkDoNwCwp3TuhXlyfYl
         vybPWSRZAHEqg0Qm11lZ3xyDQ8sslj2EQzi0igwECH/KXBeQLA6hBC9QjBA1SBWYLhbl
         UINsi6gwKipGdtAeqls6I8MsWg1PC9eMyGCC7ir4+FTvoYkB0bFBX9lwI6HzPJsQxhXA
         ff5A==
X-Gm-Message-State: AFqh2kqCAzxGR45XqWBDDe/smZIkuTxIpRyq73vevQx7D086O+OOJGA7
        bwnXpjbfFliGmvwAhXLZ1mDu3g==
X-Google-Smtp-Source: AMrXdXsvHZ9u4bFQxdqZb/uJ+OAfMpLls8q+RcQZsj1KEc+W1LBtxDQpGAZZzeXMfu0NZUkW9EKUjg==
X-Received: by 2002:a05:6870:f815:b0:14f:a68c:7c76 with SMTP id fr21-20020a056870f81500b0014fa68c7c76mr28267020oab.42.1673033443164;
        Fri, 06 Jan 2023 11:30:43 -0800 (PST)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id f8-20020a056870d14800b00136f3e4bc29sm922396oac.9.2023.01.06.11.30.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jan 2023 11:30:42 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [LSF/MM/BPF BoF] Session for Zoned Storage 2023
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <Y7h0F0w06cNM89hO@bombadil.infradead.org>
Date:   Fri, 6 Jan 2023 11:30:39 -0800
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        =?utf-8?Q?Matias_Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Hans Holmberg <hans.holmberg@wdc.com>,
        "Viacheslav A. Dubeyko" <viacheslav.dubeyko@bytedance.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4CC4F55E-17B3-47E2-A8C5-9098CCEB65D6@dubeyko.com>
References: <F6BF25E2-FF26-48F2-8378-3CB36E362313@dubeyko.com>
 <Y7h0F0w06cNM89hO@bombadil.infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jan 6, 2023, at 11:18 AM, Luis Chamberlain <mcgrof@kernel.org> =
wrote:
>=20
> On Fri, Jan 06, 2023 at 11:17:19AM -0800, Viacheslav Dubeyko wrote:
>> Hello,
>>=20
>> As far as I can see, I have two topics for discussion.
>=20
> What's that?

I am going to share these topics in separate emails. :)

(1) I am going to share SSDFS patchset soon. And topic is:
SSDFS + ZNS SSD: deterministic architecture decreasing TCO cost of data =
infrastructure.

(2) Second topic is:
How to achieve better lifetime and performance of caching layer with ZNS =
SSD?

Thanks,
Slava.

