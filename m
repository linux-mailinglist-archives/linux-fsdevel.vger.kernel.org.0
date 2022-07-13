Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170CE573BF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 19:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236463AbiGMRZ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jul 2022 13:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235854AbiGMRZu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jul 2022 13:25:50 -0400
X-Greylist: delayed 566 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Jul 2022 10:25:49 PDT
Received: from mail-relay152.hrz.tu-darmstadt.de (mail-relay152.hrz.tu-darmstadt.de [130.83.252.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDAA240AE
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jul 2022 10:25:49 -0700 (PDT)
Received: from smtp.tu-darmstadt.de (mail-relay158.hrz.tu-darmstadt.de [130.83.252.158])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits))
        (Client CN "mail-relay158.hrz.tu-darmstadt.de", Issuer "DFN-Verein Global Issuing CA" (not verified))
        by mail-relay152.hrz.tu-darmstadt.de (Postfix) with ESMTPS id 4Ljkmf2SCwz43pC;
        Wed, 13 Jul 2022 19:16:18 +0200 (CEST)
Received: from [IPV6:2001:41b8:810:20:8488:f081:d781:11f2] (unknown [IPv6:2001:41b8:810:20:8488:f081:d781:11f2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by smtp.tu-darmstadt.de (Postfix) with ESMTPSA id 4Ljkmc22jZz43VZ;
        Wed, 13 Jul 2022 19:16:16 +0200 (CEST)
Message-ID: <93f0f713-ac87-a82c-2b47-d73144739e3a@tu-darmstadt.de>
Date:   Wed, 13 Jul 2022 19:16:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   =?UTF-8?B?QW5zZ2FyIEzDtsOfZXI=?= <ansgar.loesser@tu-darmstadt.de>
Subject: Re: Information Leak: FIDEDUPERANGE ioctl allows reading writeonly
 files
Reply-To: ansgar.loesser@kom.tu-darmstadt.de
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        ansgar.loesser@kom.tu-darmstadt.de, Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Security Officers <security@kernel.org>,
        Max Schlecht <max.schlecht@informatik.hu-berlin.de>,
        =?UTF-8?Q?Bj=c3=b6rn_Scheuermann?= 
        <scheuermann@kom.tu-darmstadt.de>
References: <a7c93559-4ba1-df2f-7a85-55a143696405@tu-darmstadt.de>
 <CAHk-=wjrOgiWfN2uWf8Ajgr4SjeWMkEJ1Sd=H6pnS_JLjJwTcQ@mail.gmail.com>
 <CAEzrpqdweuZ2ufMKDJwSzP5W021F7mgS+7toSo6VDgvDzd0ZqA@mail.gmail.com>
 <CAHk-=wgEgAjX5gRntm0NutaNtjkzN+OaJVMaJAqved4dxPtAqw@mail.gmail.com>
 <Ys3TrAf95FpRgr+P@localhost.localdomain>
 <CAHk-=wi1-o-3iF09+PnNHq6_HLQhRn+32ow_f44to7_JuNCUoA@mail.gmail.com>
 <Ys4WdKSUTcvktuEl@magnolia>
In-Reply-To: <Ys4WdKSUTcvktuEl@magnolia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Header-TUDa: VM9sXjt/IuLeswNQLwCuEcKPJf1ikHgwrfmasQ25bj1ntgQaGAck+IRmSXuou9SqQHnsIpL6ucMOg7CJRxh1tEeJvtx0RWltOjspne
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> And the inode_permission() check is wrong, but at least it does have
>> the important check there (ie that FMODE_WRITE one). So doing the
>> inode_permissions() check at worst just makes it fail too often, but
>> since it's all a "optimistically dedupe" anyway, that kind of "fail in
>> odd situations" doesn't really matter.
>>
>> So for allow_file_dedupe(), I'd suggest:
>>
>>   (a) remove the inode_permission() check in allow_file_dedupe()
>>
>>   (b) remove the uid_eq() check for the same reason (if you didn't open
>> the destination for write, you have no business deduping anything,
>> even if you're the owner)
> So we're going to break userspace?
> https://github.com/markfasheh/duperemove/issues/129
> 

I am actually not sure why writability is needed for 'dest' at all. Of 
course, the deduplication might cause a write on the block device or 
underlying storage, but from the abstract fs perspective, neither the 
data nor any metadata can change, regardless of the success of the 
deduplication. The only attribute that might change is the position of 
the block on the blockdevice. Does changing this information require 
write permissions?

If I interpret the linked issue correctly, only needing read permissions 
on both fds would also solve this problem.

Best regards,
Ansgar

-- 
M.Sc. Ansgar Lößer
Fachgebiet Kommunikationsnetze
Fachbereich für Elektrotechnik und Informationstechnik
Technische Universität Darmstadt

Rundeturmstraße 10
64283 Darmstadt

E-Mail: ansgar.loesser@kom.tu-darmstadt.de
http://www.kom.tu-darmstadt.de
