Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289BF75C62C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 13:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjGUL4x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 07:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGUL4w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:56:52 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38D11986
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Jul 2023 04:56:50 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id A45B15C0116;
        Fri, 21 Jul 2023 07:56:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 21 Jul 2023 07:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1689940606; x=1690027006; bh=aOZVhJrjpFgE5d8C8KwrJjDHEERjMChgTD1
        5pR196n0=; b=TczqSg0Rh/tFbinlIIg+pssATqox/S1L+w9isTJOHHKGiP3Ebdw
        3pWSLMes8SdPgdz0zen3rn86n17XlZXfnv9XRc5KDg0yoF5mFZhUwb1dRzRrSL/m
        tGWCe2fDxIFqXq9hNKi22MUe4OvUOH2wVVmoVMUFdhvnirqLv+AD7h5OOCwVhTy6
        sXVwM8DQGGnSYvalbMQJE3aEvRZoDNCMm/BJj7F3yeuSZsEYC5/PmwO9v7gCqr+m
        BMFM9uGqESP7I9/Olt+hb/2runClMaLh7DKSJCQuIIJb/ZJurrdeHylhhfgtTCxH
        0FFmfJbzBk2mwnl6xC7tnd9XEh7qJjSOVdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1689940606; x=1690027006; bh=aOZVhJrjpFgE5d8C8KwrJjDHEERjMChgTD1
        5pR196n0=; b=HZ1BGeWDboO7wH/DcovpAe3NCiAzqWcu8Ta8yIqj+A3k1gWLGk5
        wASt2oy+EIDzzVgnavnrUyDSgREAT+MoqFVfp1LfgSoZPGLZVVamgDB+ni5+haXx
        /Si04gZFS9xmZpEPf10GqcMQeugeQPO7grDGZNqbPWquO1D2iY2nJaMQZhvYdm8Y
        kK2NLAnZC7R7QBeT1KBXSUi9eoWMr+LFFlHJqQaZsAU6VJa9SAkKMCJJcKK3ty4B
        ovcEu65ny0pOPuXLBm2qHyRbsFJMWaTMkKh3TXVnplxx0g6VHr1ik7ZokNKKfRJ7
        u/DK+OvTMp0vgSUyzyKL3D3tdAaru6eeMQA==
X-ME-Sender: <xms:fXK6ZAN-n_6teOYmJw1MKqYjQ0_YzgfUxUv0W6bq1cQyD3yT6dD1Cg>
    <xme:fXK6ZG912cE785w7Zjco1ZkgIGSUYYj-uxm_Gu1342_1rFLrtb5N3Ltx6YaYI5g8o
    lxq_vKLHaTw9tTg>
X-ME-Received: <xmr:fXK6ZHQSzWRE7PXplLg6EchLcbkys-A8LARtRI7jizAEBoK1Z5zLgZhaECkM_t4lWSSW9SQU9-Vwal2WWOXRWDMpqjIb_XTQRh6ue8LQojRNpayp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedvgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefufggjfhfkgggtgfesthhqmhdttderjeenucfhrhhomhepuegvrhhn
    ugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilh
    drfhhmqeenucggtffrrghtthgvrhhnpeffueegiefhffetveehveevffejheevkedugeef
    tdefgeduveejvdfhfedviedtgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhf
    mh
X-ME-Proxy: <xmx:fXK6ZIt_uAkO_Vlq67P-4fEVzlmWU9N5VLc2v-r5Ou1Gc4uyakO1IA>
    <xmx:fXK6ZIf0jEDeQH1NlwriymiSCZFowDmSk1-TLCZTrD0B19M0mwPOfg>
    <xmx:fXK6ZM0DEB_KLIUIazypQaZgG6QdI78l_1VkcBLJv-DovcPPOH6CwQ>
    <xmx:fnK6ZNHK8As8mi-ukdjMhYRZpmhKYfxUpyvq9utknUvWkzj-ORYfSg>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jul 2023 07:56:44 -0400 (EDT)
Date:   Fri, 21 Jul 2023 13:56:39 +0200
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
To:     Hao Xu <hao.xu@linux.dev>,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
        fuse-devel@lists.sourceforge.net
CC:     linux-fsdevel@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        cgxu519@mykernel.net, miklos@szeredi.hu
Subject: =?US-ASCII?Q?Re=3A_=5BExternal=5D_=5Bfuse-devel=5D_?= =?US-ASCII?Q?=5BPATCH_3/3=5D_fuse=3A_write_back?= =?US-ASCII?Q?_dirty_pages_before_direct_write_in_direct=5Fio=5Frelax_mode?=
User-Agent: K-9 Mail for Android
In-Reply-To: <2622afd7-228f-02f3-3b72-a1c826844126@linux.dev>
References: <20230630094602.230573-1-hao.xu@linux.dev> <20230630094602.230573-4-hao.xu@linux.dev> <e5266e11-b58b-c8ca-a3c8-0b2c07b3a1b2@bytedance.com> <2622afd7-228f-02f3-3b72-a1c826844126@linux.dev>
Message-ID: <396A0BF4-DA68-46F8-9881-3801737225C6@fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On July 21, 2023 1:27:26 PM GMT+02:00, Hao Xu <hao=2Exu@linux=2Edev> wrote:
>On 7/21/23 14:35, Jiachen Zhang wrote:
>>=20
>> On 2023/6/30 17:46, Hao Xu wrote:
>>> From: Hao Xu <howeyxu@tencent=2Ecom>
>>>=20
>>> In direct_io_relax mode, there can be shared mmaped files and thus dir=
ty
>>> pages in its page cache=2E Therefore those dirty pages should be writt=
en
>>> back to backend before direct write to avoid data loss=2E
>>>=20
>>> Signed-off-by: Hao Xu <howeyxu@tencent=2Ecom>
>>> ---
>>> =C2=A0 fs/fuse/file=2Ec | 7 +++++++
>>> =C2=A0 1 file changed, 7 insertions(+)
>>>=20
>>> diff --git a/fs/fuse/file=2Ec b/fs/fuse/file=2Ec
>>> index 176f719f8fc8=2E=2E7c9167c62bf6 100644
>>> --- a/fs/fuse/file=2Ec
>>> +++ b/fs/fuse/file=2Ec
>>> @@ -1485,6 +1485,13 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io,=
 struct iov_iter *iter,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ia)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>>> +=C2=A0=C2=A0=C2=A0 if (fopen_direct_write && fc->direct_io_relax) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res =3D filemap_write_and_=
wait_range(mapping, pos, pos + count - 1);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (res) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fu=
se_io_free(ia);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn res;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!cuse && fuse_range_is_writeback(in=
ode, idx_from, idx_to)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!write)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 inode_lock(inode);
>>=20
>> Tested-by: Jiachen Zhang <zhangjiachen=2Ejaycee@bytedance=2Ecom>
>>=20
>>=20
>> Looks good to me=2E
>>=20
>> By the way, the behaviour would be a first FUSE_WRITE flushing the page=
 cache, followed by a second FUSE_WRITE doing the direct IO=2E In the futur=
e, further optimization could be first write into the page cache and then f=
lush the dirty page to the FUSE daemon=2E
>>=20
>
>I think this makes sense, cannot think of any issue in it for now, so
>I'll do that change and send next version, super thanks, Jiachen!
>
>Thanks,
>Hao
>
>>=20
>> Thanks,
>> Jiachen
>

On my phone, sorry if mail formatting is not optimal=2E
Do I understand it right? You want DIO code path copy into pages and then =
flush/invalidate these pages? That would be punish DIO for for the unlikely=
 case there are also dirty pages (discouraged IO pattern)=2E
