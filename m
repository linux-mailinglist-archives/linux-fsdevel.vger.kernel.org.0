Return-Path: <linux-fsdevel+bounces-1137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F73C7D6628
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 11:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30FD61C20CA3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 09:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C61208C3;
	Wed, 25 Oct 2023 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OGjfttMn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8246200CC;
	Wed, 25 Oct 2023 09:03:44 +0000 (UTC)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B3A116;
	Wed, 25 Oct 2023 02:03:39 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231025090336epoutp038524091445e73f3c7d631717db811c90~RTkp-NSQY2342823428epoutp03I;
	Wed, 25 Oct 2023 09:03:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231025090336epoutp038524091445e73f3c7d631717db811c90~RTkp-NSQY2342823428epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698224616;
	bh=GiBrDjBjViAk5Td2xIPv/9YvvlgtKl2c4gSW3TckFUI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OGjfttMnWnOTkUU4RMzEelaqNn8AJiQ5XuXfSOp4Avp7abNQcjkH+/1rXmK3nrv09
	 o8f6uYNRnXfTX9BGwokFDe4vXDuJORarDYhWAkbLS7hH3N0Jof4iQrJ4DS1Azwjc8O
	 s725T64Ohrq/DWoqwS5WS5UJPtMS/wE+RrOxziOU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20231025090336epcas2p4ac9d5a1b3ad93cb97b5bba797d231846~RTkpuulyn3189731897epcas2p4I;
	Wed, 25 Oct 2023 09:03:36 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.90]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4SFjdg3y9Mz4x9Q0; Wed, 25 Oct
	2023 09:03:35 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	E6.BF.10022.7E9D8356; Wed, 25 Oct 2023 18:03:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20231025090334epcas2p35a69945505aa67c4147094c9855be036~RTkosdFnw1169011690epcas2p3A;
	Wed, 25 Oct 2023 09:03:34 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231025090334epsmtrp2f75eec4bf087e1ae7be9ee3f8550f705~RTkopWqGy2991329913epsmtrp2T;
	Wed, 25 Oct 2023 09:03:34 +0000 (GMT)
X-AuditID: b6c32a47-bfdfa70000002726-ab-6538d9e7fc66
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	3F.AA.18939.6E9D8356; Wed, 25 Oct 2023 18:03:34 +0900 (KST)
Received: from tiffany (unknown [10.229.95.142]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20231025090334epsmtip1daedeae1d940beeba6c3b6fcd2400fd3~RTkoSoejj2188821888epsmtip1Q;
	Wed, 25 Oct 2023 09:03:34 +0000 (GMT)
Date: Wed, 25 Oct 2023 17:52:58 +0900
From: Hyesoo Yu <hyesoo.yu@samsung.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, David Hildenbrand
	<david@redhat.com>, will@kernel.org, oliver.upton@linux.dev, maz@kernel.org,
	james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	arnd@arndb.de, akpm@linux-foundation.org, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	mhiramat@kernel.org, rppt@kernel.org, hughd@google.com, pcc@google.com,
	steven.price@arm.com, anshuman.khandual@arm.com, vincenzo.frascino@arm.com,
	eugenis@google.com, kcc@google.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 00/37] Add support for arm64 MTE dynamic tag storage
 reuse
Message-ID: <20231025085258.GA1355131@tiffany>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZTjWKJ0K78jeCJr-@monolith>
X-Brightmail-Tracker: H4sIAAAAAAAAA02TaUxUVxTHffPevBlowFe0eMFGySOUQgRmWK8stkEiz6oVCjGhX3AKr0CH
	WTIzNC1t0iGyTIEWRUdkChSLrGGxLLIoU8oiUEUohEU2ERkEZLGsESp04I2N3373f84/59xz
	crioWQ/HkhslVtAysSCaxI2xOy120OH5Y0jz7jcCmFVRisOM4j4cajvC4Ov0+xzY+6xfL83G
	YXCpIBWBaxWbKNRdrkHhn7mLGNQt/4zBJ9pCFhxLU2OwdnqBBeeqWzCoaljDYOWzATa819iJ
	wb6GLByOl+6wYWtFFwbrszrZ8OriNALzCj+AvU25LKh+NY/DtNFBHLb/1MSCWtUES59by4Jx
	rUs4zBwZQaCqdR2FjduvMFjTtsGB8aNu8HH+bc7HNlRpTilCbW2mI1S8dphD5VbGUPGtC2yq
	qsieqiz5Eacql9M51OjAPZzquLGFUTeVapSquvUDNVOViVBL2n6cqnrwHbVSeSSA+FzoHUkL
	wmmZFS0Ok4RHiSN8yDNBoSdD3dx5fAf+cehBWokFItqH9Dsb4HAqKlo/TNLqa0F0jF4KEMjl
	pNMJb5kkRkFbRUrkCh+SloZHSz2kjnKBSB4jjnAU0wpPPo/n7KZPvCiMbLu1jEr/PfdNVpKP
	EsnwTkaMuIBwBbMtrWgyYsw1I+oQ0JWTiO0GzIhlBKhn/JmAnrvSrrHeOBrL1w2OegT0vSg3
	PHQI2Kkd37NjhA1IWc1DdxknbEFHdQGyywcJJzBZM7fHKPESBxVLfrt8gAgGoxsv9rwmhCN4
	sDaAMPwu6Myc2tONiA/Bo83BvWKASDYGuiIlyrTkB7TxbQY+AObaqzkMW4KVxUacYSEY++ey
	gRWg/KHSkOMCNNNJhoYiwcP5RX0xrl63Bq3DGCObAlXLaw4jmwBVohnjtAZ/FORgDFuAybIk
	NsMUmBpNxZiZFKPg5sw11mXkiOat72jeqsbwMZB7dxnX6EugxGFQuM1l0A5UNDjlIuwSxJyW
	ykURtNxZ6vL/fsMkokpk77Ts/euQGwsvHZsRFhdpRgAXJQ+ahJyFtJlJuODbWFomCZXFRNPy
	ZsRNv5srqOV7YRL9bYoVoXzX4zxXd3e+h7Mbz4M8ZDKekB1uRkQIFLSQpqW07I2PxTWyVLJE
	E671tn8Jj1r4nvYFNj1Xn68s/K1wGPgtOP3iJ0rtpPusbXMwh/fOyJbkSUj+l0n7B61Xz+3A
	FD/zbkwo1mzaFyUW22Q37Bu+fsnxaSRpPFA0X5s+1HShO/luVGbe03577xDPiLC0XlVEYQv/
	i9+HLpxPNd2Z83EwWliy8Hc21/E/2lBfUrf3ExuK/gAHt4RAT13RnUNOgeNev87YTZmen3Y5
	2e2aaDI7PRa1/WjAWxfbfgJMJPjT+7NLVF9leu3LX1k/o+xZ9T0a5Ock9B5h/7LpdV0XKDo8
	51xWRn7fcVrzGb0Y1H7l06QM/03bY04ddbdd283tx2Lz/OMsUoYyjN4nMXmkgG+PyuSC/wDw
	LEdS4wQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1CTdRzH+z7Ps+d5WLd6HHR+RfNqHMitnMLV9SGTs87ung5LzsPr0rtw
	jOdQ2wC3wWVdNYtqmIBQU6FhSxTUW6LbaESwBOfc5MhLckOZgix2/AhIEM1xQgzq8r/3fV7v
	1+c+f3xYUmoSxbO78vWCNl+pltFi6scLspWrw9dBWGsZXg3mRisNh0910+DyquBhlYeBq6Fr
	86PhfRRM1B9AMN0YIWHwYBMJ7ZZxCgYnyynoczUQcLPCRIEzPEbAiOMCBcaWaQpsIb8IWtt8
	FHS3mGm4ZZ0Tgbuxi4KfzD4RfD0eRlDXkARXz1sIMD34k4aKYICGS2XnCXAZ+4n5rpOAfe4J
	Gqp7exEY3fdIaJt9QEHTxfsMlARfhOsnzjIbEnnrUSviZyJViC9x3WB4i62IL3GPiXj7STlv
	O11K87bJKoYP+ltp3ntkhuK/N5hI3n78E37IXo34Cdc1mrd3fshP2VZmctvEr+QK6l3FgnZN
	+g7xzjb7EVFha8b7o0MOyoD+StuPYljMvYDbztwj9yMxK+WcCNdNdhOLYBmumfL9m2NxX4lb
	tFgKIfxZv4mKAopLxF/drSOjmeZWYa+jHkVzHLcGDzSNoKhAcndpfMZ/eQHEclk4eH90QZZw
	Ctw57UeLW8+ReMzcxCyCJdhX/cdCieTkuGd2eP4Mdj4vxw2zbHQcwyXjXyMB8iDiah4xah4x
	av43LIg8jZ4SCnWaPI2qMEWhU2p0Rfl5ClWBxoYWPke+pRnVNz5UdCCCRR0Is6QsTvLOJhCk
	klzl3g8EbUG2tkgt6DrQcpaSLZUkqEtzpVyeUi+8JwiFgvY/SrAx8Qbi3XKHfEC1tnNyxeul
	d2j/xoGx9G+/c8+Wh53r097Q1IrSNXWB2i/atwVX5Cf3p6x3Sts9z1Y8o33b0yvbcfLoZU5j
	4VtywvqWwe3NfcfGR3JOxW2qDOVkVnYd9qaHf97ofs5R3GDE3erMHEfS81maPbbb0shcRnzo
	rXbMPHbuU9WcafRsmYar/cV76OPdrz0eWJKg2HC70tcVu9fDpf09M+U2X4y7ItmsF/SvimJ7
	hqs/T3l6cyRry0sTt1Kbk09kMB3sUFXBl9bpG7tTiTvbExKXfvRy8e+rDvUciNmaqspjsLRM
	WkAanriStMcYXvebJ5B9c132Nz84xIZjTOelN5c9KaN0O5UpclKrU/4DGmpJ4KgDAAA=
X-CMS-MailID: 20231025090334epcas2p35a69945505aa67c4147094c9855be036
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----v-9BUozlo6.4IXoMLqwHvhIp4P7gFae99qK2Oiobqpi6jGU1=_6d797_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231025031004epcas2p485a0b7a9247bc61d54064d7f7bdd1e89
References: <ebd3f142-43cc-dc92-7512-8f1c99073fce@redhat.com>
	<0b9c122a-c05a-b3df-c69f-85f520294adc@redhat.com> <ZOd2LvUKMguWdlgq@arm.com>
	<ZPhfNVWXhabqnknK@monolith> <ZP7/e8YFiosElvTm@arm.com>
	<0cc8a118-2522-f666-5bcc-af06263fd352@redhat.com> <ZQHVVdlN9QQztc7Q@arm.com>
	<CGME20231025031004epcas2p485a0b7a9247bc61d54064d7f7bdd1e89@epcas2p4.samsung.com>
	<20231025025932.GA3953138@tiffany> <ZTjWKJ0K78jeCJr-@monolith>

------v-9BUozlo6.4IXoMLqwHvhIp4P7gFae99qK2Oiobqpi6jGU1=_6d797_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Oct 25, 2023 at 09:47:36AM +0100, Alexandru Elisei wrote:
> Hi,
> 
> On Wed, Oct 25, 2023 at 11:59:32AM +0900, Hyesoo Yu wrote:
> > On Wed, Sep 13, 2023 at 04:29:25PM +0100, Catalin Marinas wrote:
> > > On Mon, Sep 11, 2023 at 02:29:03PM +0200, David Hildenbrand wrote:
> > > > On 11.09.23 13:52, Catalin Marinas wrote:
> > > > > On Wed, Sep 06, 2023 at 12:23:21PM +0100, Alexandru Elisei wrote:
> > > > > > On Thu, Aug 24, 2023 at 04:24:30PM +0100, Catalin Marinas wrote:
> > > > > > > On Thu, Aug 24, 2023 at 01:25:41PM +0200, David Hildenbrand wrote:
> > > > > > > > On 24.08.23 13:06, David Hildenbrand wrote:
> > > > > > > > > Regarding one complication: "The kernel needs to know where to allocate
> > > > > > > > > a PROT_MTE page from or migrate a current page if it becomes PROT_MTE
> > > > > > > > > (mprotect()) and the range it is in does not support tagging.",
> > > > > > > > > simplified handling would be if it's in a MIGRATE_CMA pageblock, it
> > > > > > > > > doesn't support tagging. You have to migrate to a !CMA page (for
> > > > > > > > > example, not specifying GFP_MOVABLE as a quick way to achieve that).
> > > > > > > > 
> > > > > > > > Okay, I now realize that this patch set effectively duplicates some CMA
> > > > > > > > behavior using a new migrate-type.
> > > > > [...]
> > > > > > I considered mixing the tag storage memory memory with normal memory and
> > > > > > adding it to MIGRATE_CMA. But since tag storage memory cannot be tagged,
> > > > > > this means that it's not enough anymore to have a __GFP_MOVABLE allocation
> > > > > > request to use MIGRATE_CMA.
> > > > > > 
> > > > > > I considered two solutions to this problem:
> > > > > > 
> > > > > > 1. Only allocate from MIGRATE_CMA is the requested memory is not tagged =>
> > > > > > this effectively means transforming all memory from MIGRATE_CMA into the
> > > > > > MIGRATE_METADATA migratetype that the series introduces. Not very
> > > > > > appealing, because that means treating normal memory that is also on the
> > > > > > MIGRATE_CMA lists as tagged memory.
> > > > > 
> > > > > That's indeed not ideal. We could try this if it makes the patches
> > > > > significantly simpler, though I'm not so sure.
> > > > > 
> > > > > Allocating metadata is the easier part as we know the correspondence
> > > > > from the tagged pages (32 PROT_MTE page) to the metadata page (1 tag
> > > > > storage page), so alloc_contig_range() does this for us. Just adding it
> > > > > to the CMA range is sufficient.
> > > > > 
> > > > > However, making sure that we don't allocate PROT_MTE pages from the
> > > > > metadata range is what led us to another migrate type. I guess we could
> > > > > achieve something similar with a new zone or a CPU-less NUMA node,
> > > > 
> > > > Ideally, no significant core-mm changes to optimize for an architecture
> > > > oddity. That implies, no new zones and no new migratetypes -- unless it is
> > > > unavoidable and you are confident that you can convince core-MM people that
> > > > the use case (giving back 3% of system RAM at max in some setups) is worth
> > > > the trouble.
> > > 
> > > If I was an mm maintainer, I'd also question this ;). But vendors seem
> > > pretty picky about the amount of RAM reserved for MTE (e.g. 0.5G for a
> > > 16G platform does look somewhat big). As more and more apps adopt MTE,
> > > the wastage would be smaller but the first step is getting vendors to
> > > enable it.
> > > 
> > > > I also had CPU-less NUMA nodes in mind when thinking about that, but not
> > > > sure how easy it would be to integrate it. If the tag memory has actually
> > > > different performance characteristics as well, a NUMA node would be the
> > > > right choice.
> > > 
> > > In general I'd expect the same characteristics. However, changing the
> > > memory designation from tag to data (and vice-versa) requires some cache
> > > maintenance. The allocation cost is slightly higher (not the runtime
> > > one), so it would help if the page allocator does not favour this range.
> > > Anyway, that's an optimisation to worry about later.
> > > 
> > > > If we could find some way to easily support this either via CMA or CPU-less
> > > > NUMA nodes, that would be much preferable; even if we cannot cover each and
> > > > every future use case right now. I expect some issues with CXL+MTE either
> > > > way , but are happy to be taught otherwise :)
> > > 
> > > I think CXL+MTE is rather theoretical at the moment. Given that PCIe
> > > doesn't have any notion of MTE, more likely there would be some piece of
> > > interconnect that generates two memory accesses: one for data and the
> > > other for tags at a configurable offset (which may or may not be in the
> > > same CXL range).
> > > 
> > > > Another thought I had was adding something like CMA memory characteristics.
> > > > Like, asking if a given CMA area/page supports tagging (i.e., flag for the
> > > > CMA area set?)?
> > > 
> > > I don't think adding CMA memory characteristics helps much. The metadata
> > > allocation wouldn't go through cma_alloc() but rather
> > > alloc_contig_range() directly for a specific pfn corresponding to the
> > > data pages with PROT_MTE. The core mm code doesn't need to know about
> > > the tag storage layout.
> > > 
> > > It's also unlikely for cma_alloc() memory to be mapped as PROT_MTE.
> > > That's typically coming from device drivers (DMA API) with their own
> > > mmap() implementation that doesn't normally set VM_MTE_ALLOWED (and
> > > therefore PROT_MTE is rejected).
> > > 
> > > What we need though is to prevent vma_alloc_folio() from allocating from
> > > a MIGRATE_CMA list if PROT_MTE (VM_MTE). I guess that's basically
> > > removing __GFP_MOVABLE in those cases. As long as we don't have large
> > > ZONE_MOVABLE areas, it shouldn't be an issue.
> > > 
> > 
> > How about unsetting ALLOC_CMA if GFP_TAGGED ?
> > Removing __GFP_MOVABLE may cause movable pages to be allocated in un
> > unmovable migratetype, which may not be desirable for page fragmentation.
> 
> Yes, not setting ALLOC_CMA in alloc_flags if __GFP_TAGGED is what I am
> intending to do.
> 
> > 
> > > > When you need memory that supports tagging and have a page that does not
> > > > support tagging (CMA && taggable), simply migrate to !MOVABLE memory
> > > > (eventually we could also try adding !CMA).
> > > > 
> > > > Was that discussed and what would be the challenges with that? Page
> > > > migration due to compaction comes to mind, but it might also be easy to
> > > > handle if we can just avoid CMA memory for that.
> > > 
> > > IIRC that was because PROT_MTE pages would have to come only from
> > > !MOVABLE ranges. Maybe that's not such big deal.
> > > 
> > 
> > Could you explain what it means that PROT_MTE have to come only from
> > !MOVABLE range ? I don't understand this part very well.
> 
> I believe that was with the old approach, where tag storage cannot be tagged.
> 
> I'm guessing that the idea was that during migration of a tagged page, to make
> sure that the destination page is not a tag storage page (which cannot be
> tagged), the gfp flags used for allocating the destination page would be set
> without __GFP_MOVABLE, which ensures that the destination page is not
> allocated from MIGRATE_CMA. But that is not needed anymore, if we don't set
> ALLOC_CMA if __GFP_TAGGED.
> 
> Thanks,
> Alex
> 

Hello, Alex.

If we only avoid using ALLOC_CMA for __GFP_TAGGED, would we still be able to use
the next iteration even if the hardware does not support "tag of tag" ? 
I am not sure every vendor will support tag of tag, since there is no information
related to that feature, like in the Google spec document.

we are also looking into this.

Thanks,
Regards.

> > 
> > Thanks,
> > Hyesoo.
> > 
> > > We'll give this a go and hopefully it simplifies the patches a bit (it
> > > will take a while as Alex keeps going on holiday ;)). In the meantime,
> > > I'm talking to the hardware people to see whether we can have MTE pages
> > > in the tag storage/metadata range. We'd still need to reserve about 0.1%
> > > of the RAM for the metadata corresponding to the tag storage range when
> > > used as data but that's negligible (1/32 of 1/32). So if some future
> > > hardware allows this, we can drop the page allocation restriction from
> > > the CMA range.
> > > 
> > > > > though the latter is not guaranteed not to allocate memory from the
> > > > > range, only make it less likely. Both these options are less flexible in
> > > > > terms of size/alignment/placement.
> > > > > 
> > > > > Maybe as a quick hack - only allow PROT_MTE from ZONE_NORMAL and
> > > > > configure the metadata range in ZONE_MOVABLE but at some point I'd
> > > > > expect some CXL-attached memory to support MTE with additional carveout
> > > > > reserved.
> > > > 
> > > > I have no idea how we could possibly cleanly support memory hotplug in
> > > > virtual environments (virtual DIMMs, virtio-mem) with MTE. In contrast to
> > > > s390x storage keys, the approach that arm64 with MTE took here (exposing tag
> > > > memory to the VM) makes it rather hard and complicated.
> > > 
> > > The current thinking is that the VM is not aware of the tag storage,
> > > that's entirely managed by the host. The host would treat the guest
> > > memory similarly to the PROT_MTE user allocations, reserve metadata etc.
> > > 
> > > Thanks for the feedback so far, very useful.
> > > 
> > > -- 
> > > Catalin
> > > 
> 
> 
> 

------v-9BUozlo6.4IXoMLqwHvhIp4P7gFae99qK2Oiobqpi6jGU1=_6d797_
Content-Type: text/plain; charset="utf-8"


------v-9BUozlo6.4IXoMLqwHvhIp4P7gFae99qK2Oiobqpi6jGU1=_6d797_--

