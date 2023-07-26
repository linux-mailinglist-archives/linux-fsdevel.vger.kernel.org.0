Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E226763589
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 13:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbjGZLpT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 07:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbjGZLpP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:45:15 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D2F2D5D;
        Wed, 26 Jul 2023 04:44:46 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-98df3dea907so1025953566b.3;
        Wed, 26 Jul 2023 04:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690371824; x=1690976624;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LucON46rxCnB8H/NqbP2qdCDDBI9z5ydH1MkYVoh1II=;
        b=U4Pt4NQcLxLvPm5CXftoA0+aYzMZH7Dfck0Uhx7aEMgpLJsGnf36pzzdwNtizBn8gj
         VFXJFEQbls5KGalhlHlOQYeiqewjs9kc+4BUmOlw3IWdU7XqOmJehEWyn+XP5Q9fSvcv
         EcQa8xdjNjWdOP1pTlUcVpcyGyC+9VXTxQgEu7gkqQtKv7/nWgsdUciQ3staM4V8TP3p
         +GoW2+8LeGfmIGAc6HsjnX9h4U8ECXsZezBtZPiwG9Punsry2P/Xcv2oit9C6Y66+kxc
         QJOvEDzBI1Rt8s8NMDhxwQxdZujdb/Azg73NjikgVhHbnq8tIiDLm5dNL2h7e2gZIvR/
         ntOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690371824; x=1690976624;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LucON46rxCnB8H/NqbP2qdCDDBI9z5ydH1MkYVoh1II=;
        b=dP6QOnjFXmDj285Ojaiipn8tkQlPt1XwvKBwLlJxyCfJ94bpZDOko8V6z73d99N/2f
         1CulJJfIDWwyQ9qf6EiR7WI+8x2HuOTm1XeuSbp3uQt+CjRYVV0U2NYeSA6jfV3FmaUP
         +C6FU3OLIiejZQObGoY4OA91ZopiqcJLUfgkhUaJY8zMiR4mVnY//DwvxfVSXbIlFozY
         1Wc0oL+mtGjndBEGS3DihXi0DOLHau0RBPqI9vBT7VYwqqH9MQ8IfvKNBM1iVn3aY5tu
         nHbfCtsknJKj2ubm2StbDM6LHzjIV9huaQxebwHnyZw65Yqq9MgXFIyRhBI5Fc+rHqoD
         pbpw==
X-Gm-Message-State: ABy/qLb9Gbu9L7Ed1I1ETG6GusUqOhghnwpZ6WzYo2L1Uprm4++Bb7N2
        b4Qq8kOAXO6hPGzF4y40IGM=
X-Google-Smtp-Source: APBJJlFndmwsKn44klgr7dJH1x6WY6kkEbF8sug4Ovo4JtP2oBsigyyob1BXXzwdhRutSwmlT6/YBQ==
X-Received: by 2002:a17:906:3048:b0:992:ab3a:f0d4 with SMTP id d8-20020a170906304800b00992ab3af0d4mr1346049ejd.17.1690371823534;
        Wed, 26 Jul 2023 04:43:43 -0700 (PDT)
Received: from [192.168.0.103] ([77.126.7.132])
        by smtp.gmail.com with ESMTPSA id s5-20020a170906168500b00991e2b5a27dsm9372329ejd.37.2023.07.26.04.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 04:43:43 -0700 (PDT)
Message-ID: <fed78210-4560-b655-b43a-bc31d1cfe1b8@gmail.com>
Date:   Wed, 26 Jul 2023 14:43:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v10 08/16] tls: Inline do_tcp_sendpages()
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
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
References: <bbdce803-0f23-7d3f-f75a-2bc3cfb794af@gmail.com>
 <ecbb5d7e-7238-28e2-1a17-686325e2bb50@gmail.com>
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
 <20418.1690368701@warthog.procyon.org.uk>
From:   Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20418.1690368701@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,WEIRD_PORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 26/07/2023 13:51, David Howells wrote:
> Tariq Toukan <ttoukan.linux@gmail.com> wrote:
> 
>> We repro the issue on the server side using this client command:
>> $ wrk -b2.2.2.2 -t4 -c1000 -d5 --timeout 5s https://2.2.2.3:20443/256000b.img
> 
> What's wrk?
> 
> David
> 

Pretty known and standard client app.
wrk - a HTTP benchmarking tool
https://github.com/wg/wrk
