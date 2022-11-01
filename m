Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AEE6144A5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 07:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiKAG0g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 02:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiKAG0e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 02:26:34 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1A612ADC
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Oct 2022 23:26:32 -0700 (PDT)
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221101062626epoutp04f7f1f094a12e6816db4f60d8ff73711d~jYfPGfbcJ1570515705epoutp04T
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Nov 2022 06:26:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221101062626epoutp04f7f1f094a12e6816db4f60d8ff73711d~jYfPGfbcJ1570515705epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667283986;
        bh=HGoN9c97e9QlZmh/CU9/eZVdiIV/mHkPom4dBvjUqwg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=pStQ7rTep70a2sr/pm453fS3MSgUomyQKK3H4L8wo5/jKNUlTIZgGJpncUSjCccbl
         XslrLuBuM9ktlSLCzXLnp6CdVu7fuFlWDjZmANx14VJO7olKTOm1aHAswFlqYL0SL4
         C9C2M6Sq8EOzh0XUJBRti6GurSGAaw11ea6omoAg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20221101062626epcas1p420f65ba6b078adbe468c6cdf89afd72d~jYfOyB14E2435524355epcas1p4B;
        Tue,  1 Nov 2022 06:26:26 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.243]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4N1g5Y6vwvz4x9Q1; Tue,  1 Nov
        2022 06:26:25 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        3C.01.57013.01CB0636; Tue,  1 Nov 2022 15:26:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20221101062624epcas1p3c5fb524dc8bab19b24e9d42b35777392~jYfNMgp4J0133401334epcas1p3W;
        Tue,  1 Nov 2022 06:26:24 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221101062624epsmtrp1ed6da4f62e99674c33807e1544eaffe5~jYfNLuCwq0225602256epsmtrp1u;
        Tue,  1 Nov 2022 06:26:24 +0000 (GMT)
X-AuditID: b6c32a37-5b141a800001deb5-09-6360bc10b3a4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CB.60.18644.01CB0636; Tue,  1 Nov 2022 15:26:24 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221101062624epsmtip21c8271111d4ef7f482fdefcc53d37c15~jYfNBwcAP1909719097epsmtip2x;
        Tue,  1 Nov 2022 06:26:24 +0000 (GMT)
From:   "Sungjong Seo" <sj1557.seo@samsung.com>
To:     "'Namjae Jeon'" <linkinjeon@kernel.org>
Cc:     "'linux-fsdevel'" <linux-fsdevel@vger.kernel.org>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>,
        <sj1557.seo@samsung.com>
In-Reply-To: <PUZPR04MB631665D55F4F0B290D0D543581379@PUZPR04MB6316.apcprd04.prod.outlook.com>
Subject: RE: [PATCH v1 1/2] exfat: simplify empty entry hint
Date:   Tue, 1 Nov 2022 15:26:24 +0900
Message-ID: <322d01d8edba$dd8e7370$98ab5a50$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJj/zaSoZMPYtmG2fVrgFRBP80hpwJaGMqRAj8XxoYBK3U6ygIPfv+NrNRwc8A=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMJsWRmVeSWpSXmKPExsWy7bCmrq7gnoRkg+evmC0mTlvKbLFn70kW
        i8u75rBZbPl3hNWBxWPTqk42j74tqxg9Pm+SC2COamC0SSxKzsgsS1VIzUvOT8nMS7dVCg1x
        07VQUsjILy6xVYo2NDTSMzQw1zMyMtIztoy1MjJVUshLzE21VarQhepVUihKLgCqza0sBhqQ
        k6oHFdcrTs1LccjKLwU5Ua84Mbe4NC9dLzk/V0mhLDGnFGiEkn7CN8aMw2euMxf8taqYff4A
        YwPjZ7MuRk4OCQETiQO/PrJ2MXJxCAnsYJSYdm4OG4TziVFiwdN/TBDOZ0aJHQ9vMcO0rDq/
        lgnEFhLYxShx4a4CRNFLRolvd3+zgyTYBHQlntz4CdTAwSEioC1x/0U6SA2zQBOjxITGlywg
        NZwCsRIr9j4CqxcWsJF40XkObAGLgIrEs/2PWEFsXgFLib3HN7JD2IISJ2c+AetlBpq5bOFr
        qIMUJHZ/OsoKsctPYmJ7JUSJiMTszjZmkL0SAm/ZJZ6s3swOUe8icejzZiYIW1ji1fEtUHEp
        iZf9bVB2N6PEn3O8EM0TGCVa7pxlhUgYS3z6/JkRZBmzgKbE+l36EGFFiZ2/5zJC2IISp691
        M0McwSfx7msP2G0SArwSHW1CECUqEt8/7GSZwKg8C8lns5B8NgvJC7MQli1gZFnFKJZaUJyb
        nlpsWGCMHN+bGMHpU8t8B+O0tx/0DjEycTAeYpTgYFYS4a0/G50sxJuSWFmVWpQfX1Sak1p8
        iDEZGNYTmaVEk/OBCTyvJN7QxNjAwAiYDM0tzY2JELY0MDEzMrEwtjQ2UxLnbZihlSwkkJ5Y
        kpqdmlqQWgSzhYmDU6qB6dgPlQnqDkKyp2LUWpkU5E73+iiKHyo8UTvPQf9UkW93fO67WZtd
        30nZb9r2WGCjZ8vle1Xfl9ZKvPi86n11kEe50vZXzzx+pd6YZ1QqmTA79PKsLSerDVv37LCS
        PCX5JPpcaiXz9CVqId+UVhZ8qNi7sHaN8HKmQnmf6/m2270eyS8NFFGe9GVL3cuI19PD79T6
        8UgYeBry/ImV9q5pePEm4clX0xny+7Y+qtzS+PzkmqzXvhX781Iv2C9eMUVcZGVpsnV07fRr
        q0NWGZv2bBGwVjir/fnMIXaV92/lNz+rv7I6q0XpUdO/C8r1E/benF7P4neab5fA/cJDccuj
        mYSXlrydphzyYuoj9S9daUosxRmJhlrMRcWJALMdBC9WBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSvK7AnoRkg+NtyhYTpy1lttiz9ySL
        xeVdc9gstvw7wurA4rFpVSebR9+WVYwenzfJBTBHcdmkpOZklqUW6dslcGW0fhcqeK5dceF3
        G1sD41qlLkZODgkBE4lV59cygdhCAjsYJe5Nju5i5ACKS0kc3KcJYQpLHD5c3MXIBVTxnFFi
        2esnbCDlbAK6Ek9u/GQGqRER0Ja4/yIdpIZZoIVRomHXSaiRn5gkpq7TBbE5BWIlVux9xA5i
        CwvYSLzoPMcMYrMIqEg82/+IFcTmFbCU2Ht8IzuELShxcuYTFhCbGWj+05tP4exlC18zQ5yv
        ILH701FWiBv8JCa2V0KUiEjM7mxjnsAoPAvJpFlIJs1CMmkWkpYFjCyrGCVTC4pz03OLDQuM
        8lLL9YoTc4tL89L1kvNzNzGCY0JLawfjnlUf9A4xMnEwHmKU4GBWEuGtPxudLMSbklhZlVqU
        H19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAOTa0nEi3D1gPPJG3u21De+
        SdNaEXyqv6ldujv5gjarXGHBlP+WidX5nx86r9JRycg+zrTz+bdkhy3WktGvN/929FrpvqX6
        xMeSNSfEZh6cxXUzuCss7HT7BdaqBYcenr93iKmq+nLd7uv1l7VX3v/brBNnmCn8eLsfW7De
        Y5njC0PfTw09tvKceuhZcbuMx9dZ8ipTTh3h39G2mEfZfYMqn9nlVibhRewt60PFHNtCgl9s
        Obe1ZmWmlvLt/duP5IqHM5/OC+ux4CtfdOd29iWupOP1a/6nC+7YslRsmelpgc+/j+Q+1fm5
        5KpRGkdC86NE4/PMfdusZ2y/xmIvL7h5DsPJmible1Z3F98zEJdWYinOSDTUYi4qTgQAE7i0
        FfgCAAA=
X-CMS-MailID: 20221101062624epcas1p3c5fb524dc8bab19b24e9d42b35777392
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-ArchiveUser: EV
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221019072850epcas1p459b27e0d44eb0cc36ec09e9a734dcf60
References: <CGME20221019072850epcas1p459b27e0d44eb0cc36ec09e9a734dcf60@epcas1p4.samsung.com>
        <PUZPR04MB6316EBE97C82DFBEFE3CCDAF812B9@PUZPR04MB6316.apcprd04.prod.outlook.com>
        <000001d8ece8$0241bca0$06c535e0$@samsung.com>
        <CAKYAXd__ypbjLpnNVDxf3UE4M+au2QwYYe2PeY8QsKZCBaO54w@mail.gmail.com>
        <PUZPR04MB631665D55F4F0B290D0D543581379@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Yuezhang,
I am sorry that I cannot reply directly to you due to environmental restric=
tions.

> > > BTW, ei->hint_femp.count was already reset at the beginning of
> > > exfat_find_dir_entry(). So condition-check above could be removed.
> > > Is there any scenario I'm missing?
>=20
> If the search does not start from the first entry and there are not enoug=
h
> empty entries.
> This condition will be true when rewinding.

I didn't get what you said. do you mean =22ei->hint_femp.eidx > dentry=22?
Even so, it could be true, if the search does not start from the first entr=
y
and there are =22enough=22 empty entries.

Anyway, what I'm saying is =22ei->hint_femp.count < num_entries=22, and hin=
t_femp
Seems to be reset as EXFAT_HINT_NONE with 0 by below code.

+	if (ei->hint_femp.eidx =21=3D EXFAT_HINT_NONE &&
+	    ei->hint_femp.count < num_entries)
+		ei->hint_femp.eidx =3D EXFAT_HINT_NONE;
+
+	if (ei->hint_femp.eidx =3D=3D EXFAT_HINT_NONE)
+		ei->hint_femp.count =3D 0;

After then, ei->hint_femp can be updated only if there are enough free entr=
ies.

>=20
> > >> -	candi_empty.eidx =3D EXFAT_HINT_NONE;
> > >> +	if (ei->hint_femp.eidx =21=3D EXFAT_HINT_NONE &&
> > >> +	    ei->hint_femp.count < num_entries)
> > >> +		ei->hint_femp.eidx =3D EXFAT_HINT_NONE;
> > >> +
> > >> +	if (ei->hint_femp.eidx =3D=3D EXFAT_HINT_NONE)
> > >> +		ei->hint_femp.count =3D 0;
> > >> +
> > >> +	candi_empty =3D ei->hint_femp;
> > >> +
> > >
> > > It would be nice to make the code block above a static inline functio=
n
> > > as well.
>=20
> Since the code is called once only in exfat_find_dir_entry(), I didn't
> make a function for the code.
>=20
> How about make function exfat_reset_empty_hint_if_not_enough() for this
> code?
> The function name is a bit long=E2=98=B9,=20do=20you=20have=20a=20better=
=20idea?=0D=0A>=20=0D=0A>=20Or=20maybe,=20we=20can=20add=20exfat_reset_empt=
y_hint()=20and=20unconditionally=20reset=0D=0A>=20ei->hint_femp=20in=20it.=
=0D=0A=0D=0AIt's=20always=20difficult=20for=20me=20as=20well=20:).=0D=0AWha=
t=20do=20you=20think=20of=20exfat_test_reset_empty_hint()=20or=0D=0Aexfat_c=
ond_reset_empty_hint()?=0D=0A=0D=0A>=20>=20-----Original=20Message-----=0D=
=0A>=20>=20From:=20Namjae=20Jeon=20<linkinjeon=40kernel.org>=0D=0A>=20>=20S=
ent:=20Monday,=20October=2031,=202022=202:31=20PM=0D=0A>=20>=20To:=20Sungjo=
ng=20Seo=20<sj1557.seo=40samsung.com>;=20Mo,=20Yuezhang=0D=0A>=20>=20<Yuezh=
ang.Mo=40sony.com>=0D=0A>=20>=20Cc:=20linux-fsdevel=20<linux-fsdevel=40vger=
.kernel.org>;=20linux-kernel=0D=0A>=20>=20<linux-kernel=40vger.kernel.org>=
=0D=0A>=20>=20Subject:=20Re:=20=5BPATCH=20v1=201/2=5D=20exfat:=20simplify=
=20empty=20entry=20hint=0D=0A>=20>=0D=0A>=20>=20Add=20missing=20Cc:=20Yuezh=
ang=20Mo.=0D=0A>=20>=0D=0A>=20>=202022-10-31=2014:16=20GMT+09:00,=20Sungjon=
g=20Seo=20<sj1557.seo=40samsung.com>:=0D=0A>=20>=20>=20Hello,=20Yuezhang=20=
Mo,=0D=0A>=20>=20>=0D=0A>=20>=20>>=20This=20commit=20adds=20exfat_hint_empt=
y_entry()=20to=20reduce=20code=20complexity=0D=0A>=20>=20>>=20and=20make=20=
code=20more=20readable.=0D=0A>=20>=20>>=0D=0A>=20>=20>>=20Signed-off-by:=20=
Yuezhang=20Mo=20<Yuezhang.Mo=40sony.com>=0D=0A>=20>=20>>=20Reviewed-by:=20A=
ndy=20Wu=20<Andy.Wu=40sony.com>=0D=0A>=20>=20>>=20Reviewed-by:=20Aoyama=20W=
ataru=20<wataru.aoyama=40sony.com>=0D=0A>=20>=20>>=20---=0D=0A>=20>=20>>=20=
=20fs/exfat/dir.c=20=7C=2056=0D=0A>=20>=20>>=20++++++++++++++++++++++++++++=
----------------------=0D=0A>=20>=20>>=20=201=20file=20changed,=2032=20inse=
rtions(+),=2024=20deletions(-)=0D=0A>=20>=20>>=0D=0A>=20>=20>>=20diff=20--g=
it=20a/fs/exfat/dir.c=20b/fs/exfat/dir.c=20index=0D=0A>=20>=20>>=207b648b66=
62f0..a569f285f4fd=20100644=0D=0A>=20>=20>>=20---=20a/fs/exfat/dir.c=0D=0A>=
=20>=20>>=20+++=20b/fs/exfat/dir.c=0D=0A>=20>=20>>=20=40=40=20-934,6=20+934=
,24=20=40=40=20struct=20exfat_entry_set_cache=0D=0A>=20>=20>>=20*exfat_get_=
dentry_set(struct=20super_block=20*sb,=0D=0A>=20>=20>>=20=20=09return=20NUL=
L;=0D=0A>=20>=20>>=20=20=7D=0D=0A>=20>=20>>=0D=0A>=20>=20>>=20+static=20inl=
ine=20void=20exfat_hint_empty_entry(struct=20exfat_inode_info=0D=0A>=20*ei,=
=0D=0A>=20>=20>>=20+=09=09struct=20exfat_hint_femp=20*candi_empty,=20struct=
=20exfat_chain=20*clu,=0D=0A>=20>=20>>=20+=09=09int=20dentry,=20int=20num_e=
ntries)=0D=0A>=20>=20>>=20+=7B=0D=0A>=20>=20>>=20+=09if=20(ei->hint_femp.ei=
dx=20=3D=3D=20EXFAT_HINT_NONE=20=7C=7C=0D=0A>=20>=20>>=20+=09=20=20=20=20ei=
->hint_femp.count=20<=20num_entries=20=7C=7C=0D=0A>=20>=20>=0D=0A>=20>=20>=
=20It=20seems=20like=20a=20good=20approach.=0D=0A>=20>=20>=20BTW,=20ei->hin=
t_femp.count=20was=20already=20reset=20at=20the=20beginning=20of=0D=0A>=20>=
=20>=20exfat_find_dir_entry().=20So=20condition-check=20above=20could=20be=
=20removed.=0D=0A>=20>=20>=20Is=20there=20any=20scenario=20I'm=20missing?=
=0D=0A>=20>=20>=0D=0A>=20>=20>>=20+=09=20=20=20=20ei->hint_femp.eidx=20>=20=
dentry)=20=7B=0D=0A>=20>=20>>=20+=09=09if=20(candi_empty->count=20=3D=3D=20=
0)=20=7B=0D=0A>=20>=20>>=20+=09=09=09candi_empty->cur=20=3D=20*clu;=0D=0A>=
=20>=20>>=20+=09=09=09candi_empty->eidx=20=3D=20dentry;=0D=0A>=20>=20>>=20+=
=09=09=7D=0D=0A>=20>=20>>=20+=0D=0A>=20>=20>>=20+=09=09candi_empty->count++=
;=0D=0A>=20>=20>>=20+=09=09if=20(candi_empty->count=20=3D=3D=20num_entries)=
=0D=0A>=20>=20>>=20+=09=09=09ei->hint_femp=20=3D=20*candi_empty;=0D=0A>=20>=
=20>>=20+=09=7D=0D=0A>=20>=20>>=20+=7D=0D=0A>=20>=20>>=20+=0D=0A>=20>=20>>=
=20=20enum=20=7B=0D=0A>=20>=20>>=20=20=09DIRENT_STEP_FILE,=0D=0A>=20>=20>>=
=20=20=09DIRENT_STEP_STRM,=0D=0A>=20>=20>>=20=40=40=20-958,7=20+976,7=20=40=
=40=20int=20exfat_find_dir_entry(struct=20super_block=20*sb,=0D=0A>=20>=20>=
>=20struct=20exfat_inode_info=20*ei,=20=20=7B=0D=0A>=20>=20>>=20=20=09int=
=20i,=20rewind=20=3D=200,=20dentry=20=3D=200,=20end_eidx=20=3D=200,=20num_e=
xt=20=3D=200,=20len;=0D=0A>=20>=20>>=20=20=09int=20order,=20step,=20name_le=
n=20=3D=200;=0D=0A>=20>=20>>=20-=09int=20dentries_per_clu,=20num_empty=20=
=3D=200;=0D=0A>=20>=20>>=20+=09int=20dentries_per_clu;=0D=0A>=20>=20>>=20=
=20=09unsigned=20int=20entry_type;=0D=0A>=20>=20>>=20=20=09unsigned=20short=
=20*uniname=20=3D=20NULL;=0D=0A>=20>=20>>=20=20=09struct=20exfat_chain=20cl=
u;=0D=0A>=20>=20>>=20=40=40=20-976,7=20+994,15=20=40=40=20int=20exfat_find_=
dir_entry(struct=20super_block=20*sb,=0D=0A>=20>=20>>=20struct=20exfat_inod=
e_info=20*ei,=0D=0A>=20>=20>>=20=20=09=09end_eidx=20=3D=20dentry;=0D=0A>=20=
>=20>>=20=20=09=7D=0D=0A>=20>=20>>=0D=0A>=20>=20>>=20-=09candi_empty.eidx=
=20=3D=20EXFAT_HINT_NONE;=0D=0A>=20>=20>>=20+=09if=20(ei->hint_femp.eidx=20=
=21=3D=20EXFAT_HINT_NONE=20&&=0D=0A>=20>=20>>=20+=09=20=20=20=20ei->hint_fe=
mp.count=20<=20num_entries)=0D=0A>=20>=20>>=20+=09=09ei->hint_femp.eidx=20=
=3D=20EXFAT_HINT_NONE;=0D=0A>=20>=20>>=20+=0D=0A>=20>=20>>=20+=09if=20(ei->=
hint_femp.eidx=20=3D=3D=20EXFAT_HINT_NONE)=0D=0A>=20>=20>>=20+=09=09ei->hin=
t_femp.count=20=3D=200;=0D=0A>=20>=20>>=20+=0D=0A>=20>=20>>=20+=09candi_emp=
ty=20=3D=20ei->hint_femp;=0D=0A>=20>=20>>=20+=0D=0A>=20>=20>=0D=0A>=20>=20>=
=20It=20would=20be=20nice=20to=20make=20the=20code=20block=20above=20a=20st=
atic=20inline=20function=0D=0A>=20>=20>=20as=20well.=0D=0A>=20>=20>=0D=0A>=
=20>=20>>=20=20rewind:=0D=0A>=20>=20>>=20=20=09order=20=3D=200;=0D=0A>=20>=
=20>>=20=20=09step=20=3D=20DIRENT_STEP_FILE;=0D=0A>=20>=20>=20=5Bsnip=5D=0D=
=0A>=20>=20>>=20--=0D=0A>=20>=20>>=202.25.1=0D=0A>=20>=20>=0D=0A>=20>=20>=
=0D=0A=0D=0A
