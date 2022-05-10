Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BA15226D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 00:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbiEJW2n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 18:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiEJW2m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 18:28:42 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED89C50B12
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 May 2022 15:28:39 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j10-20020a17090a94ca00b001dd2131159aso3207391pjw.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 May 2022 15:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:from:cc
         :subject:content-transfer-encoding;
        bh=wfPHY8O5lpAXCbOKekK8DfHBJ0WH0D1/nUeEmSt+v20=;
        b=z5+JwAqr5bItL7ZbzMQ0W/I1TkosIfL+BkwL9FvGWgGcgnRvYA+kho8sI0uuZtmw9h
         U1Dp4jz+YgVu4PrYB6U/nDairICKgp5B3qMmk4w3AIJYGHOkX5tlgWDKpwGZyxYoKYB0
         XZXHciGVY9/EeycnNPX2f4n+VkHfUs1chM6hTUDjM3QqUDSrsWrez0WBPQByjRJrNP1b
         A9E2gxwFAUVTDsGl6T68iL/kwe4ATYBVTcC5s3wdF/bNNmBVS/+md+OJ5frlqd8BEuI5
         BCffEznNIWLl1pF7aD9F170mFMM4IscmjQ5D2GAw310i2gP8cQIDyWCjVZ+X9hASxRcM
         V8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:cc:subject:content-transfer-encoding;
        bh=wfPHY8O5lpAXCbOKekK8DfHBJ0WH0D1/nUeEmSt+v20=;
        b=A2669ptszc8ZwVs7hF/XbihkYbe1e1HPynfYQ7hMmTZDhoeo1lyPZ3uUvn68RnXE8+
         c1gMLzSZs4rJ07gMPwXbMW4SRgTQHJG5SiscDFXgwfXAzppy8WQrbo4hIo9MWjKU/y59
         gNrSordbEdf/Lg5vEkSfz6KOqJ0nLva+vbpJSx4tF78MCS36P1QHvaFWsHq4ek99FWHn
         Sgx5pIHVIEOCtL+iymE2DCnxarbIsznffPGyJMIse7m49VszokoSxXL6X0wa3mz/pR8e
         MRApI9be8AB9l1CN+RDKHna5I8MsAsJbg7dWqVc8TFDlGpBuQTLmcfCEA9OmAUHFrxvM
         gp/Q==
X-Gm-Message-State: AOAM5310jbKI8XQYDLfgC7199ECSlUa3Cq2HuJejbx+S4EUzd1qTiwXT
        uU70FDadyKZIYBMrYBQFt0bcSQ==
X-Google-Smtp-Source: ABdhPJxIlNn2Wj+2MuilRsO5BYUSZc7ybzcGHgfGbJI6n2IvJXDB35OlIpH+/GbDFCpAVdmq0z7RPA==
X-Received: by 2002:a17:90a:8914:b0:1dc:20c0:40f4 with SMTP id u20-20020a17090a891400b001dc20c040f4mr2016927pjn.11.1652221719446;
        Tue, 10 May 2022 15:28:39 -0700 (PDT)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id mz18-20020a17090b379200b001dcc0cb262asm197584pjb.17.2022.05.10.15.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 15:28:38 -0700 (PDT)
Message-ID: <49ac1697-5235-ca2e-2738-f0399c26d718@linaro.org>
Date:   Tue, 10 May 2022 15:28:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     linux-ext4@vger.kernel.org
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: kernel BUG in ext4_writepages
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,
Syzbot found another BUG in ext4_writepages [1].
This time it complains about inode with inline data.
C reproducer can be found here [2]
I was able to trigger it on 5.18.0-rc6

[1] https://syzkaller.appspot.com/bug?id=a1e89d09bbbcbd5c4cb45db230ee28c822953984
[2] https://syzkaller.appspot.com/text?tag=ReproC&x=129da6caf00000

-- 
Thanks,
Tadeusz
