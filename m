Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9DF785B19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 16:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbjHWOvt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 10:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbjHWOvs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:51:48 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA091E6A
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 07:51:44 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 4F1D43200124;
        Wed, 23 Aug 2023 10:51:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 23 Aug 2023 10:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1692802300; x=1692888700; bh=IyR6Vz7Eqm3JmagTI4u6H7CFleUhJ5Iga2n
        umve45bY=; b=iYqni6syzx0VYvivyL+7Sxm06OQtSNh149NVeVNs7l6HFQ1ot3K
        qPhBqkDWmfTzt+URCNqp8vf6WrbFkZAwrFTOhs6R/rlvzJ/KuNdKdGXyr0GkaLRd
        J2xLRDSybXoB2kTwRKc9Q8PGJktlDw8nu/+SW/U+CaAepEcvH3ofn/iDoNbqZqrT
        8KfQLiit6gHzomJzwiSqreXZaReWHh0Ao0c3rLMrmXXOpZiL8Bh47eoejyhm4F+t
        rBAsFoW0iWNIAqXeCZjbDu3w53PlhjwmIg8PY7clNflJ9cWRApJ3Vye1Fj++yODi
        nSO0+v7zU5Ede8zBXDtb5KNrJs0fMPqfjCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1692802300; x=1692888700; bh=IyR6Vz7Eqm3JmagTI4u6H7CFleUhJ5Iga2n
        umve45bY=; b=OH80YQlnzjR2b/XsYwSsd8Z/Qg6gSNCRnStiM45sM51FCzcubb8
        V16+rrIUME0RZIluAwktq5TQalKAHhd517+Xbl4ffmlnq6qdEaTWCstlrrvo/VNK
        c9kQzM0lfrqKyeBv6QfNr5LvLdEso5f5Wd6cLiaqfAFK1MdUN3k3/ImkbT9pwYzH
        AbtdBMkK/NTlAm2Mdfapm+d6pCM/RzyzVXLG/SA/CKW6jpuBY116CSX8OrfhtPL+
        xpNzKgzpDcPPzmW1NCQJbjpya6qCKF2uRK3igaKrVeVcmgJoJYaRbPf9QtPsiu70
        foW/VqN7oLdx72fZJHB4PEWc6eIj6wv+ttA==
X-ME-Sender: <xms:_BzmZNRtRokpEzV6w8rsKOfQYfez0T4LFSLiHcSdiKAs1kpA-w9KLA>
    <xme:_BzmZGxXDxnNmwPwQk3PZtf7Ah3wkAS7bpwuGVqYdaJyKD_vtEcpTbkDH_bGA4WzH
    M87zg-zgd1HOiLb>
X-ME-Received: <xmr:_BzmZC2ZA6slXZFpldQ6AtdldBvpB5p_5YFhT2cbHVVQmqMTnBdCnfWryF1BNha4a0fcKR3wdKqOmwgAgKe0BIkM56fFuG4SVfxZxKcmz08fiaTcBiCJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvgedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepkeehveekleekkeejhfehgeeftdffuddujeej
    ieehheduueelleeghfeukeefvedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:_BzmZFAShoxu6B8hB1nq2D9sj_gEYRd_cpvwHXbsGf4uGgNXZA3RXQ>
    <xmx:_BzmZGhwjcdCLika20MDDcGBJdk2YORN9fTeku9I1wgR5BFE_hiLMw>
    <xmx:_BzmZJro_FpPhokUolfzRdQbFsFjXQo4sZPOZR-fAch3O9fEuFRtXA>
    <xmx:_BzmZKYXj9PhMrHHpa13RI6x7D325WseBRqy2Vh4TEQkbwuFZ7A5JA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Aug 2023 10:51:39 -0400 (EDT)
Message-ID: <410b7d7d-b930-4580-3342-c66b3985555d@fastmail.fm>
Date:   Wed, 23 Aug 2023 16:51:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 4/5] fuse: implement statx
Content-Language: en-US, de-DE
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
References: <20230810105501.1418427-1-mszeredi@redhat.com>
 <20230810105501.1418427-5-mszeredi@redhat.com>
 <067fcdfa-0a99-4731-0ea1-a799fff51480@fastmail.fm>
 <CAJfpeguEmafkUPqZO2_EAOWbw+7XUm0E9whVpnnj_MVf2fnStQ@mail.gmail.com>
 <9ebc2bcb-5ffd-e82f-9836-58f375f881ea@fastmail.fm>
 <CAJfpegvqdAa+XjHA2VefEu=QZNQHyYnXC988UxPfPMisCj93jA@mail.gmail.com>
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <CAJfpegvqdAa+XjHA2VefEu=QZNQHyYnXC988UxPfPMisCj93jA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/23/23 08:18, Miklos Szeredi wrote:
> On Tue, 22 Aug 2023 at 18:55, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>>
>>
>>
>> On 8/22/23 17:33, Miklos Szeredi wrote:
>>> On Tue, 22 Aug 2023 at 17:20, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>>>>
>>>> Hi Miklos,
>>>>
>>>> sorry for late review.
>>>>
>>>> On 8/10/23 12:55, Miklos Szeredi wrote:
>>>> [...]
>>>>> +static int fuse_do_statx(struct inode *inode, struct file *file,
>>>>> +                      struct kstat *stat)
>>>>> +{
>>>>> +     int err;
>>>>> +     struct fuse_attr attr;
>>>>> +     struct fuse_statx *sx;
>>>>> +     struct fuse_statx_in inarg;
>>>>> +     struct fuse_statx_out outarg;
>>>>> +     struct fuse_mount *fm = get_fuse_mount(inode);
>>>>> +     u64 attr_version = fuse_get_attr_version(fm->fc);
>>>>> +     FUSE_ARGS(args);
>>>>> +
>>>>> +     memset(&inarg, 0, sizeof(inarg));
>>>>> +     memset(&outarg, 0, sizeof(outarg));
>>>>> +     /* Directories have separate file-handle space */
>>>>> +     if (file && S_ISREG(inode->i_mode)) {
>>>>> +             struct fuse_file *ff = file->private_data;
>>>>> +
>>>>> +             inarg.getattr_flags |= FUSE_GETATTR_FH;
>>>>> +             inarg.fh = ff->fh;
>>>>> +     }
>>>>> +     /* For now leave sync hints as the default, request all stats. */
>>>>> +     inarg.sx_flags = 0;
>>>>> +     inarg.sx_mask = STATX_BASIC_STATS | STATX_BTIME;
>>>>
>>>>
>>>>
>>>> What is actually the reason not to pass through flags from
>>>> fuse_update_get_attr()? Wouldn't it make sense to request the minimal
>>>> required mask and then server side can decide if it wants to fill in more?
>>>
>>> This and following commit is about btime and btime only.  It's about
>>> adding just this single attribute, otherwise the logic is unchanged.
>>>
>>> But the flexibility is there in the interface definition, and
>>> functionality can be added later.
>>
>> Sure, though what speaks against setting (limiting the mask) right away?
> 
> But then the result is basically uncacheable, until we have separate
> validity timeouts for each attribute.  Maybe we need that, maybe not,
> but it does definitely have side effects.

Ah right, updating the cache timeout shouldn't be done unless the reply 
contains all attributes. Although you already handle that in fuse_do_statx


	if ((sx->mask & STATX_BASIC_STATS) == STATX_BASIC_STATS) {
		fuse_change_attributes(inode, &attr, &outarg.stat,
				       ATTR_TIMEOUT(&outarg), attr_version);
	}



Thanks,
Bernd
