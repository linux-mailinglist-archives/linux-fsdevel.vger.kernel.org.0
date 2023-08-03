Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF34776E76D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 13:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbjHCLwZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 07:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHCLwX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:52:23 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B434FE6F;
        Thu,  3 Aug 2023 04:52:18 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe2de785e7so1553861e87.1;
        Thu, 03 Aug 2023 04:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691063537; x=1691668337;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BvfpzHNvraxrRTuqY8Qx7g7HYM0fDeaGxzfbp5eLMZY=;
        b=KiVP/jJm3Mv4SHlqquH9+PvoWiGwU4w43ceFJW+SVvK1dooJfh1HtQVCCsJQst7wzj
         191CRtHrTNxg7iyvORcNn2rvdqjIWavgBms97K9kq+ivY7hQBtW/gaNz7ofp6M4HmzDp
         DN9yCDbGGKmz3sasKBFiPHuKJsi7q4UTfEvnu7OtDbPzlu0GNWeat1z15W8VMrK6IgeF
         fukNf2GCSLYup8R12ZkJ91letJnvIZj0cOvIjwCJowcA9pf2qg0wwLpsUWhoRwraXB7b
         nPBtBqfrJwIl9MtUIf+caGzToRM49uz3+yMd49z6r0Z2LaPUC08ZW+V351CEdLPjMVui
         TSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691063537; x=1691668337;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BvfpzHNvraxrRTuqY8Qx7g7HYM0fDeaGxzfbp5eLMZY=;
        b=K495OK/KaDCx9EXwCpc9fmDck8bojipxqCqN79q9VxOAiHZPF41Njkt5GhVQ2eH0xm
         ap0EL+WOE+sTT5gqxqpMxZtOEOSL0gyaQx/QU1FMStC2xDtDjtVfd3oiUfcqhgJETAOl
         HGTrRNziHDpDIqUGnvqRSyFyCEF7kQ2Ag7jbizihKDqdfDvnFA9LbxtfT8hRvCz9pFWk
         hxGT2gqtwduZ62G8tpSWgIn2QidbhglqEFzkAFyCrAIRdFm3Ios+oy5H+GuFm0TA2WOt
         tZJkvT6OnxEbOCmxSHFoERijUE4s1teVHOJSq9iamhUs8b9ghFaRmXIT5lBd6FSf+Ewe
         IK8A==
X-Gm-Message-State: ABy/qLbowS5LEJyHN32NKp291M2B+Voh2lPTL4vQbqiwl5QUFCPflZkS
        NcKOpwo+3Vcup95KYR/Rjhg=
X-Google-Smtp-Source: APBJJlFCc7jU7XPSLQb+MCmbbcT8NiK3hMDPzGpNm10epcXYfUELg5To/dMsKpdwiHJYRmJAXj+7bQ==
X-Received: by 2002:ac2:4d97:0:b0:4fb:829b:197c with SMTP id g23-20020ac24d97000000b004fb829b197cmr6396758lfe.52.1691063536736;
        Thu, 03 Aug 2023 04:52:16 -0700 (PDT)
Received: from [192.168.0.103] ([77.126.7.132])
        by smtp.gmail.com with ESMTPSA id lt5-20020a170906fa8500b0098f99048053sm10663624ejb.148.2023.08.03.04.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 04:52:16 -0700 (PDT)
Message-ID: <006fc25b-497b-7de0-1d69-b7be66ab31b3@gmail.com>
Date:   Thu, 3 Aug 2023 14:52:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v10 08/16] tls: Inline do_tcp_sendpages()
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Howells <dhowells@redhat.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Gal Pressman <gal@nvidia.com>, ranro@nvidia.com,
        samiram@nvidia.com, drort@nvidia.com,
        Tariq Toukan <tariqt@nvidia.com>
References: <ecbb5d7e-7238-28e2-1a17-686325e2bb50@gmail.com>
 <4c49176f-147a-4283-f1b1-32aac7b4b996@gmail.com>
 <20230522121125.2595254-1-dhowells@redhat.com>
 <20230522121125.2595254-9-dhowells@redhat.com>
 <2267272.1686150217@warthog.procyon.org.uk>
 <5a9d4ffb-a569-3f60-6ac8-070ab5e5f5ad@gmail.com>
 <776549.1687167344@warthog.procyon.org.uk>
 <7337a904-231d-201d-397a-7bbe7cae929f@gmail.com>
 <20230630102143.7deffc30@kernel.org>
 <f0538006-6641-eaf6-b7b5-b3ef57afc652@gmail.com>
 <20230705091914.5bee12f8@kernel.org>
 <bbdce803-0f23-7d3f-f75a-2bc3cfb794af@gmail.com>
 <20230725173036.442ba8ba@kernel.org>
 <e9c41176-829a-af5a-65d2-78a2f414cd04@gmail.com>
 <20230726130819.6cc6aa0c@kernel.org>
From:   Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20230726130819.6cc6aa0c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 26/07/2023 23:08, Jakub Kicinski wrote:
> On Wed, 26 Jul 2023 22:20:42 +0300 Tariq Toukan wrote:
>>> There is a small bug in this commit, we should always set SPLICE.
>>> But I don't see how that'd cause the warning you're seeing.
>>> Does your build have CONFIG_DEBUG_VM enabled?
>>
>> No.
>>
>> # CONFIG_DEBUG_VM is not set
>> # CONFIG_DEBUG_VM_PGTABLE is not set
> 
> Try testing v6.3 with DEBUG_VM enabled or just remove the IS_ENABLED()
> from: https://github.com/torvalds/linux/blob/v6.4/net/ipv4/tcp.c#L1051

Tested. It doesn't repro.
